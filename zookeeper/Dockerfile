FROM registry.cn-zhangjiakou.aliyuncs.com/atguigu-practice/java as source
RUN curl -L https://dlcdn.apache.org/zookeeper/zookeeper-3.7.1/apache-zookeeper-3.7.1-bin.tar.gz | tar -zx --no-same-owner && \
    mv apache-zookeeper-3.7.1-bin /opt/module/zookeeper && \
    mkdir /opt/module/zookeeper/zkData

COPY config /opt/module/zookeeper/conf

RUN chown -R atguigu:atguigu /opt/module

FROM registry.cn-zhangjiakou.aliyuncs.com/atguigu-practice/java
COPY --from=source --chown=atguigu:atguigu /opt/module/zookeeper /opt/module/zookeeper
COPY env.sh /etc/profile.d/zookeeper.sh
COPY init.sh /root/.init/01_zookeeper.sh
COPY --chown=atguigu:atguigu --chmod=755 zk.sh /home/atguigu/bin/zk.sh
