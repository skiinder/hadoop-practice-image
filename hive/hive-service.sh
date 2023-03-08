#!/bin/bash
LOG_FILE=/tmp/atguigu/hive.log

# 启动
function hive_start() {
  # 检查MySQL
  if ! nc -z hadoop101 3306; then
    echo "MySQL没有启动"
    exit 1
  fi
  # 检查HDFS
  # shellcheck disable=SC2046
  if ! nc -z $(hdfs getconf -nnRpcAddresses | sed 's/:/ /'); then
    echo "HDFS没有启动"
    exit 1
  fi

  # 等待安全模式
  hdfs dfsadmin -safemode wait

  if nc -z hadoop102 10000; then
    echo "HIVE 已经启动"
  else
    nohup hiveserver2 >"${HIVE_HOME}/server2.log" 2>&1 &
  fi

  # 等到10000端口成功开启再推出，如果超过一定时间，无论开没开都退出
  TIMER=60
  while [ "$TIMER" -gt 0 ] && ! nc -z hadoop102 10000; do
    sleep 1
    ((TIMER--))
  done

  if ! nc -z hadoop102 10000; then
    echo "HiveServer2启动失败，以下为日志"
    tail -n 300 "${LOG_FILE}"
    hive_stop
  fi
}

# 停止
function hive_stop() {
  pkill -f HiveServer2
  sleep 2
  [ "$(pgrep -f HiveServer2)" ] && pkill -f -9 HiveServer2
}

# 查看状态
function hive_status() {
  if nc -z hadoop102 10000; then
    echo "HIVE 正常运行"
    return 0
  else
    echo "HIVE 状态异常"
    return 1
  fi
}

case $1 in
'start')
  hive_start
  ;;
'stop')
  hive_stop
  ;;
'restart')
  hive_stop
  sleep 2
  hive_start
  ;;
'status')
  hive_status
  ;;
*)
  echo "$0 start|stop|status|restart"
  ;;
esac
