#!/bin/bash
set -ex
if [ "$HOSTNAME" = "hadoop102" ]; then
  # 等待其他peer准备完毕
  while ! nc -z hadoop103 22; do
    echo '等待hadoop103准备就绪'
    sleep 1
  done
  while ! nc -z hadoop104 22; do
    echo '等待hadoop104准备就绪'
    sleep 1
  done
  su - atguigu -c "
start-dfs.sh
stop-dfs.sh
hdfs namenode -format -force
"
fi
