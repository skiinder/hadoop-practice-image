function question() {
  clear
  cat <<'EOF'
Flume启动后会出现问题，请排查。启动Flume的命令如下：
/opt/module/flume/bin/flume-ng agent -n a1 -c /opt/module/flume/conf -f /opt/module/flume/conf/flume.conf
EOF
}
