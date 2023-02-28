#! /bin/bash
case $1 in
"start")
  xcall "/opt/module/kafka/bin/kafka-server-start.sh -daemon /opt/module/kafka/config/server.properties"
  ;;
"stop")
  xcall "/opt/module/kafka/bin/kafka-server-stop.sh"
esac
