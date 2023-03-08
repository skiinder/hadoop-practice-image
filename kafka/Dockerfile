FROM registry.cn-zhangjiakou.aliyuncs.com/atguigu-practice/flume as source
RUN curl -L https://dlcdn.apache.org/kafka/3.3.2/kafka_2.12-3.3.2.tgz | tar -zx --no-same-owner && \
    mv kafka_2.12-3.3.2 /opt/module/kafka

COPY config /opt/module/kafka/config

RUN chown -R atguigu:atguigu /opt/module

FROM registry.cn-zhangjiakou.aliyuncs.com/atguigu-practice/flume
COPY --from=source --chown=atguigu:atguigu /opt/module/kafka /opt/module/kafka

COPY env.sh /etc/profile.d/kafka.sh
COPY init.sh /root/.init/04_kafka.sh
COPY --chown=atguigu:atguigu --chmod=755 kf.sh /home/atguigu/bin/kf.sh
