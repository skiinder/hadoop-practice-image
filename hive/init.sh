#!/bin/bash
set -ex
if [ "$HOSTNAME" = "hadoop102" ]; then
  su - atguigu -c "
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
  stop-dfs.sh
  "
fi