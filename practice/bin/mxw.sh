#!/bin/bash

MAXWELL_HOME=/opt/module/maxwell

start_maxwell() {
  if [ "$(pgrep -c com.zendesk.maxwell.Maxwell)" -lt 1 ]; then
    echo "启动Maxwell"
    $MAXWELL_HOME/bin/maxwell --config $MAXWELL_HOME/config.properties --daemon
  else
    echo "Maxwell正在运行"
  fi
}

stop_maxwell() {
  status_maxwell
  if [ "$(pgrep -c com.zendesk.maxwell.Maxwell)" -gt 0 ]; then
    echo "停止Maxwell"
    pkill -f -9 com.zendesk.maxwell.Maxwell
  else
    echo "Maxwell未在运行"
  fi
}

case $1 in
start)
  start_maxwell
  ;;
stop)
  stop_maxwell
  ;;
restart)
  stop_maxwell
  start_maxwell
  ;;
esac
