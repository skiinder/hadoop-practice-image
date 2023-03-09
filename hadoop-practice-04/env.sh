clear
echo "等待节点准备完毕..."
while ! [ -e /root/.init/READY ]; do
  sleep 1
done
cat <<'EOF'
HDFS启动后运行不正常，请检查并排除故障。
EOF
