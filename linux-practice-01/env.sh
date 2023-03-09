function question() {
  clear
  cat <<'EOF'
启动数仓集群后，尝试以下操作：
1. 查找占用8032端口的进程。
2. 在Hadoop102节点查找flume进程，并查看该进程的堆内存详情。
3. 将Hadoop、Hive、Flume和Kafka的堆内存大小改为1GB。
4. 分别查看各个框架的日志。
EOF
}
