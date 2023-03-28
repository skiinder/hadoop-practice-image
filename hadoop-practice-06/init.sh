#!/bin/bash
set -ex
if [ "$HOSTNAME" = "hadoop102" ]; then
  # 等待其他peer准备完毕
  while ! nc -z hadoop103 22; do
    echo '等待hadoop103准备就绪'
    sleep 1
  done
  while ! nc -z hadoop104 22; do
    echo '等待hadoop104准备就绪'
    sleep 1
  done
  su - atguigu -c "
start-dfs.sh
mkdir -p test

for i in {1..100} ; do
    echo \$i\$i\$i\$i\$i > test/\$i
done
hdfs dfsadmin -safemode wait
hadoop fs -put test /
xcall killall -9 java
rm -rf test
xcall 'find  /opt/module/hadoop/data/dfs/data/current -type f | grep \"subdir0\" | xargs -rn5 rm'
"
fi
