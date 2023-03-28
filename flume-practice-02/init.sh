su - atguigu -c "
zk.sh start
sleep 1
kf.sh start
sleep 2
kafka-topics.sh --bootstrap-server hadoop102:9092 --topic topic-source --create --partitions 3 --replication-factor 1
kafka-producer-perf-test.sh --num-records 10000000 --record-size 1024 --producer-props bootstrap.servers=hadoop102:9092 --throughput -1 --topic topic-source
"