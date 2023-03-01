#!/bin/bash
APPLOG_HOME="/opt/module/applog"
MXW_HOME="/opt/module/maxwell"
POSITION_FILE="${FLUME_HOME:-'/opt/module/flume'}/taildir_position.json"
INIT_DAY='2022-06-08'
# 不要设置低于2天
INIT_DAY_COUNT=15

function set_application_yaml() {
    sed -i "/$1/s/.*/$1: \"$2\"/" "/opt/module/applog/application.yml"
}

function generate_log() {
    cd "$APPLOG_HOME" || return
    if [ "$1" ]; then
      set_application_yaml 'mock.date' "$1"
    fi
    java -jar "$(ls ./*.jar)"
}

function reset_maxwell() {
    cd "$MXW_HOME" || return
    sed -i "/mock_date/d" config.properties
    echo "mock_date=$1" >> config.properties
    /home/atguigu/bin/mxw.sh restart
}

case $1 in
[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9])
  reset_maxwell "$1"
  generate_log "$1"
  ;;
"init")
  /home/atguigu/bin/mxw.sh stop
  mysql -uroot -p000000 -hhadoop101 -e"drop database if exists maxwell;"
  mysql -uroot -p000000 -hhadoop101 -e"create database maxwell;"
  ((INIT_DAY_COUNT--))
  day="$(date -d "$INIT_DAY -$INIT_DAY_COUNT days" +%F)"
  set_application_yaml 'mock.clear.busi' '1'
  set_application_yaml 'mock.clear.user' '1'
  generate_log "$day"
  set_application_yaml 'mock.clear.busi' '0'
  set_application_yaml 'mock.clear.user' '0'
  while ((INIT_DAY_COUNT>1))
  do
    ((INIT_DAY_COUNT--))
    day="$(date -d "$INIT_DAY -$INIT_DAY_COUNT days" +%F)"
    generate_log "$day"
  done
  rm -rf "$APPLOG_HOME/log"
  rm -rf "$POSITION_FILE"
  ((INIT_DAY_COUNT--))
  day="$(date -d "$INIT_DAY -$INIT_DAY_COUNT days" +%F)"
  generate_log "$day"
  reset_maxwell "$INIT_DAY"
  ;;
*)
  echo "参数输入错误"
  ;;
esac
