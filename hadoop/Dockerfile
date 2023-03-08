FROM registry.cn-zhangjiakou.aliyuncs.com/atguigu-practice/zookeeper as source
RUN curl -L https://dlcdn.apache.org/hadoop/common/hadoop-3.3.4/hadoop-3.3.4.tar.gz | tar -zx --no-same-owner && \
    mv hadoop-3.3.4 /opt/module/hadoop && \
    rm -rf /opt/module/hadoop/share/doc

COPY config /opt/module/hadoop/etc/hadoop

RUN chown -R atguigu:atguigu /opt/module

FROM registry.cn-zhangjiakou.aliyuncs.com/atguigu-practice/zookeeper
COPY --from=source --chown=atguigu:atguigu /opt/module/hadoop /opt/module/hadoop
COPY env.sh /etc/profile.d/hadoop.sh
COPY init.sh /root/.init/02_hadoop.sh
COPY --chown=atguigu:atguigu --chmod=755 hdp.sh /home/atguigu/bin/hdp.sh
