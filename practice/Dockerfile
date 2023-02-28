FROM registry.cn-zhangjiakou.aliyuncs.com/atguigu-practice/base-centos as source
RUN curl -L https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u352-b08/OpenJDK8U-jdk_x64_linux_hotspot_8u352b08.tar.gz | tar -zx --no-same-owner && \
    mv jdk8u352-b08 /opt/module/java

RUN curl -L https://dlcdn.apache.org/zookeeper/zookeeper-3.7.1/apache-zookeeper-3.7.1-bin.tar.gz | tar -zx --no-same-owner && \
    mv apache-zookeeper-3.7.1-bin /opt/module/zookeeper && \
    mkdir /opt/module/zookeeper/zkData

RUN curl -L https://dlcdn.apache.org/hadoop/common/hadoop-3.3.4/hadoop-3.3.4.tar.gz | tar -zx --no-same-owner && \
    mv hadoop-3.3.4 /opt/module/hadoop && \
    rm -rf /opt/module/hadoop/share/doc

RUN curl -L https://github.com/skiinder/hive/releases/download/221031/apache-hive-3.1.3-bin.tar.gz | tar -zx --no-same-owner && \
    mv apache-hive-3.1.3-bin /opt/module/hive && \
    rm -rf /opt/module/hive/lib/log4j-slf4j-impl-2.17.1.jar && \
    curl -L https://repo.maven.apache.org/maven2/com/mysql/mysql-connector-j/8.0.31/mysql-connector-j-8.0.31.jar -o /opt/module/hive/lib/mysql-connector-j-8.0.31.jar

RUN curl -L https://dlcdn.apache.org/spark/spark-3.3.2/spark-3.3.2-bin-without-hadoop.tgz | tar -zx --no-same-owner && \
    mv spark-3.3.2-bin-without-hadoop /opt/module/spark

RUN curl -L https://dlcdn.apache.org/tez/0.10.2/apache-tez-0.10.2-bin.tar.gz | tar -zx --no-same-owner && \
    mv apache-tez-0.10.2-bin /opt/module/tez

RUN curl -L https://dlcdn.apache.org/flume/1.11.0/apache-flume-1.11.0-bin.tar.gz | tar -zx --no-same-owner && \
    mv apache-flume-1.11.0-bin /opt/module/flume

RUN curl -L https://dlcdn.apache.org/kafka/3.3.2/kafka_2.12-3.3.2.tgz | tar -zx --no-same-owner && \
    mv kafka_2.12-3.3.2 /opt/module/kafka

RUN curl -L https://dlcdn.apache.org/hbase/2.4.16/hbase-2.4.16-bin.tar.gz | tar -zx --no-same-owner && \
    mv hbase-2.4.16 /opt/module/hbase

RUN curl -L https://dlcdn.apache.org/phoenix/phoenix-5.1.3/phoenix-hbase-2.4-5.1.3-bin.tar.gz | tar -zx --no-same-owner && \
    curl -L https://dlcdn.apache.org/phoenix/phoenix-queryserver-6.0.0/phoenix-queryserver-6.0.0-bin.tar.gz | tar -zx --no-same-owner && \
    mv phoenix-queryserver-6.0.0 /opt/module/phoenix && \
    mv phoenix-hbase-2.4-5.1.3-bin/phoenix-server-hbase-2.4-5.1.3.jar /opt/module/hbase/lib && \
    mv phoenix-hbase-2.4-5.1.3-bin/phoenix-client-hbase-2.4-5.1.3.jar /opt/module/phoenix

RUN curl -L https://github.com/skiinder/DataX/releases/download/20230107/datax.tar.gz | tar -zx --no-same-owner && \
    mv datax /opt/module/datax

RUN curl -L https://github.com/skiinder/maxwell/releases/download/230204/maxwell-1.29.2.tar.gz | tar -zx --no-same-owner && \
    mv maxwell-1.29.2 /opt/module/maxwell

RUN curl -L https://dlcdn.apache.org/flink/flink-1.16.1/flink-1.16.1-bin-scala_2.12.tgz | tar -zx --no-same-owner && \
    mv flink-1.16.1 /opt/module/flink

COPY hadoop /opt/module/hadoop/etc/hadoop
COPY zookeeper /opt/module/zookeeper/conf
COPY hive /opt/module/hive/conf
COPY kafka /opt/module/kafka/config
COPY flume /opt/module/flume/conf
COPY maxwell /opt/module/maxwell
COPY spark /opt/module/spark/conf
COPY bin /home/atguigu/bin
RUN chmod +x /home/atguigu/bin/*

RUN chown -R atguigu:atguigu /opt/module

FROM registry.cn-zhangjiakou.aliyuncs.com/atguigu-practice/base-centos
COPY --from=source --chown=atguigu:atguigu /opt/module/java /opt/module/java
COPY --from=source --chown=atguigu:atguigu /opt/module/zookeeper /opt/module/zookeeper
COPY --from=source --chown=atguigu:atguigu /opt/module/hadoop /opt/module/hadoop
COPY --from=source --chown=atguigu:atguigu /opt/module/hive /opt/module/hive
COPY --from=source --chown=atguigu:atguigu /opt/module/tez /opt/module/tez
COPY --from=source --chown=atguigu:atguigu /opt/module/flume /opt/module/flume
COPY --from=source --chown=atguigu:atguigu /opt/module/kafka /opt/module/kafka
COPY --from=source --chown=atguigu:atguigu /opt/module/maxwell /opt/module/maxwell
COPY --from=source --chown=atguigu:atguigu /opt/module/spark /opt/module/spark
COPY --from=source --chown=atguigu:atguigu /opt/module/hbase /opt/module/hbase
COPY --from=source --chown=atguigu:atguigu /opt/module/phoenix /opt/module/phoenix
COPY --from=source --chown=atguigu:atguigu /opt/module/datax /opt/module/datax
COPY --from=source --chown=atguigu:atguigu /opt/module/flink /opt/module/flink
COPY --from=source --chown=atguigu:atguigu /home/atguigu/bin /home/atguigu/bin

RUN curl -LO https://downloads.mysql.com/archives/get/p/23/file/mysql-community-client-8.0.31-1.el7.x86_64.rpm && \
    curl -LO https://downloads.mysql.com/archives/get/p/23/file/mysql-community-client-plugins-8.0.31-1.el7.x86_64.rpm && \
    curl -LO https://downloads.mysql.com/archives/get/p/23/file/mysql-community-common-8.0.31-1.el7.x86_64.rpm && \
    curl -LO https://downloads.mysql.com/archives/get/p/23/file/mysql-community-libs-8.0.31-1.el7.x86_64.rpm && \
    curl -LO https://downloads.mysql.com/archives/get/p/23/file/mysql-community-libs-compat-8.0.31-1.el7.x86_64.rpm && \
    yum install -y *.rpm && \
    yum clean all && \
    rm -rf *.rpm

COPY my_env.sh /etc/profile.d/my_env.sh
COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

ENV JAVA_HOME=/opt/module/java ZOOKEEPER_HOME=/opt/module/zookeeper HADOOP_HOME=/opt/module/hadoop HIVE_HOME=/opt/module/hive FLUME_HOME=/opt/module/flume KAFKA_HOME=/opt/module/kafka TEZ_HOME=/opt/module/tez SPARK_HOME=/opt/module/spark HBASE_HOME=/opt/module/hbase PHOENIX_HOME=/opt/module/phoenix DATAX_HOME=/opt/module/datax FLINK_HOME=/opt/module/flink
ENV PATH=$PATH:$JAVA_HOME/bin:$ZOOKEEPER_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$HIVE_HOME/bin:$FLUME_HOME/bin:$KAFKA_HOME/bin:$SPARK_HOME/bin:$SPARK_HOME/sbin:$HBASE_HOME/bin:$HBASE_HOME/sbin:$PHOENIX_HOME/bin:$DATAX_HOME/bin:$FLINK_HOME/bin
