function question() {
  clear
  cat <<'EOF'
实现以下功能的Flume：
采集某一个文本文件到HDFS，文件内容长短不定。
将字符数量大于20的行，采集到 '/flume/long' 文件夹
将字符数量不大于20的行，采集到 '/flume/short' 文件夹
提示：
  1. 实现一个Flume拦截器添加自定义Header
  2. 在HDFS sink中引用自定义Header作为文件夹名
EOF
}
