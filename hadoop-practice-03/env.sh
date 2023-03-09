clear
echo "等待节点准备完毕..."
while ! [ -e /root/.init/READY ]; do
  sleep 1
done
cat <<'EOF'
HDFS无法启动，请检查并排查错误。
EOF
