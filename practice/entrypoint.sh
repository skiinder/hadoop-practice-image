#!/bin/bash

# 启动sshd
/sbin/sshd

if ! [ -e /root/READY ]; then
  # 初始化
  case "$(hostname)" in
  "hadoop102")
    su - atguigu -c "
    hdfs namenode -format -nonInteractive
    echo 2 >/opt/module/zookeeper/zkData/myid
    sed -i -e 's/^broker\.id.*/broker.id=2/' -e 's/^advertised\.listeners.*/advertised.listeners=PLAINTEXT:\/\/hadoop102:9092/' /opt/module/kafka/config/server.properties
    while ! nc -z hadoop101 3306; do
      echo '等待MySQL准备就绪'
      sleep 1
    done
    mysql -hhadoop101 -uroot -p000000 -e'create database metastore;'
    schematool -validate -dbType mysql || schematool -initSchema -dbType mysql -verbose
    mysql -hhadoop101 -uroot -p000000 -e'
    alter table metastore.COLUMNS_V2 modify column COMMENT varchar(256) character set utf8;
    alter table metastore.TABLE_PARAMS modify column PARAM_VALUE mediumtext character set utf8;'
    while ! nc -z hadoop103 22; do
      echo '等待hadoop103准备就绪'
      sleep 1
    done
    while ! nc -z hadoop104 22; do
      echo '等待hadoop104准备就绪'
      sleep 1
    done
    start-dfs.sh
    sleep 1
    hdfs dfsadmin -safemode wait
    hadoop fs -mkdir -p hdfs://hadoop102:8020/spark/history
    hadoop fs -mkdir -p hdfs://hadoop102:8020/spark/jars
    hadoop fs -put /opt/module/spark/jars/* hdfs://hadoop102:8020/spark/jars/
    stop-dfs.sh"
    ;;
  "hadoop103")
    su - atguigu -c "
    echo 3 >/opt/module/zookeeper/zkData/myid
    sed -i -e 's/^broker\.id.*/broker.id=3/' -e 's/^advertised\.listeners.*/advertised.listeners=PLAINTEXT:\/\/hadoop103:9092/' /opt/module/kafka/config/server.properties
    "
    ;;
  "hadoop104")
    su - atguigu -c "
    echo 4 >/opt/module/zookeeper/zkData/myid
    sed -i -e 's/^broker\.id.*/broker.id=4/' -e 's/^advertised\.listeners.*/advertised.listeners=PLAINTEXT:\/\/hadoop104:9092/' /opt/module/kafka/config/server.properties
    "
    ;;
  esac
fi

touch /root/READY

# 启动ttyd
/bin/ttyd su - atguigu
