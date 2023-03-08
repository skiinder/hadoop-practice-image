#!/bin/bash
set -ex
# 初始化数仓环境
# 开启集群
zk.sh start
hdp.sh start
kf.sh start
# 初始化MySQL
mysql -uroot -p000000 -hhadoop101 -e"
drop database if exists gmall;
drop database if exists gmall_report;
create database gmall charset utf8mb4 COLLATE utf8mb4_general_ci;
create database gmall_report charset utf8mb4 COLLATE utf8mb4_general_ci;
"
mysql -uroot -p000000 -hhadoop101 -D'gmall' < /opt/module/table-create-sql/gmall.sql
mysql -uroot -p000000 -hhadoop101 -D'gmall_report' < /opt/module/table-create-sql/create_report.sql
# 初始化hive表格
hdfs dfsadmin -safemode wait
hive -e "create database gmall"
hive -f "/opt/module/table-create-sql/create_ads.sql"
hive -f "/opt/module/table-create-sql/create_dim.sql"
hive -f "/opt/module/table-create-sql/create_dwd.sql"
hive -f "/opt/module/table-create-sql/create_dws_1d.sql"
hive -f "/opt/module/table-create-sql/create_dws_nd.sql"
hive -f "/opt/module/table-create-sql/create_dws_td.sql"
hive -f "/opt/module/table-create-sql/create_ods.sql"
hadoop fs -put /opt/module/table-create-sql/date_info.txt /warehouse/gmall/tmp/tmp_dim_date_info/
hive -e "insert into gmall.dim_date select * from gmall.tmp_dim_date_info;"
cd /opt/module/datax-config-generator
java -jar datax-config-generator-1.0-SNAPSHOT-jar-with-dependencies.jar
f1.sh start
f2.sh start
f3.sh start
mock.sh init

mysql_to_kafka_inc_init.sh all
mysql_to_hdfs_full.sh all 2022-06-08
hdfs_to_ods_log.sh 2022-06-08
hdfs_to_ods_db.sh all 2022-06-08
ods_to_dim_init.sh all 2022-06-08
ods_to_dwd_init.sh all 2022-06-08
dwd_to_dws_1d_init.sh all 2022-06-08
dws_1d_to_dws_nd.sh all 2022-06-08
dws_1d_to_dws_td_init.sh all 2022-06-08
dws_to_ads.sh all 2022-06-08
hdfs_to_mysql.sh all
