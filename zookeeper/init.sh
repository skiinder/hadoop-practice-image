#!/bin/bash
case "$(hostname)" in
"hadoop102")
  su - atguigu -c "echo 2 >/opt/module/zookeeper/zkData/myid"
  ;;
"hadoop103")
  su - atguigu -c "echo 3 >/opt/module/zookeeper/zkData/myid"
  ;;
"hadoop104")
  su - atguigu -c "echo 4 >/opt/module/zookeeper/zkData/myid"
  ;;
esac