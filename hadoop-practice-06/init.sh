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
