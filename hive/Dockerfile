FROM registry.cn-zhangjiakou.aliyuncs.com/atguigu-practice/hadoop as source

RUN curl -L https://github.com/skiinder/hive/releases/download/221031/apache-hive-3.1.3-bin.tar.gz | tar -zx --no-same-owner && \
    mv apache-hive-3.1.3-bin /opt/module/hive && \
    rm -rf /opt/module/hive/lib/log4j-slf4j-impl-2.17.1.jar && \
    curl -L https://repo.maven.apache.org/maven2/com/mysql/mysql-connector-j/8.0.31/mysql-connector-j-8.0.31.jar -o /opt/module/hive/lib/mysql-connector-j-8.0.31.jar

RUN curl -L https://dlcdn.apache.org/spark/spark-3.3.2/spark-3.3.2-bin-without-hadoop.tgz | tar -zx --no-same-owner && \
    mv spark-3.3.2-bin-without-hadoop /opt/module/spark

COPY config/hive-site.xml /opt/module/hive/conf/hive-site.xml
COPY config/spark-defaults.conf /opt/module/hive/conf/spark-defaults.conf
COPY config/spark-env.sh /opt/module/spark/conf/spark-env.sh

RUN chown -R atguigu:atguigu /opt/module

FROM registry.cn-zhangjiakou.aliyuncs.com/atguigu-practice/hadoop
COPY --from=source --chown=atguigu:atguigu /opt/module/hive /opt/module/hive
COPY --from=source --chown=atguigu:atguigu /opt/module/spark /opt/module/spark
COPY env.sh /etc/profile.d/hive.sh
COPY init.sh /root/.init/03_hive.sh
COPY --chown=atguigu:atguigu --chmod=755 hive-service.sh /home/atguigu/bin/hive-service.sh
