#!/bin/bash
case "$(hostname)" in
"hadoop102")
  su - atguigu -c "sed -i -e 's/^broker\.id.*/broker.id=2/' -e 's/^advertised\.listeners.*/advertised.listeners=PLAINTEXT:\/\/hadoop102:9092/' /opt/module/kafka/config/server.properties"
  ;;
"hadoop103")
  su - atguigu -c "sed -i -e 's/^broker\.id.*/broker.id=3/' -e 's/^advertised\.listeners.*/advertised.listeners=PLAINTEXT:\/\/hadoop103:9092/' /opt/module/kafka/config/server.properties"
  ;;
"hadoop104")
  su - atguigu -c "sed -i -e 's/^broker\.id.*/broker.id=4/' -e 's/^advertised\.listeners.*/advertised.listeners=PLAINTEXT:\/\/hadoop104:9092/' /opt/module/kafka/config/server.properties"
  ;;
esac