FROM registry.cn-zhangjiakou.aliyuncs.com/atguigu-practice/hive as source

RUN curl -L https://dlcdn.apache.org/flume/1.11.0/apache-flume-1.11.0-bin.tar.gz | tar -zx --no-same-owner && \
    mv apache-flume-1.11.0-bin /opt/module/flume
COPY config /opt/module/flume/conf
RUN chown -R atguigu:atguigu /opt/module

FROM registry.cn-zhangjiakou.aliyuncs.com/atguigu-practice/hive
COPY --from=source --chown=atguigu:atguigu /opt/module/flume /opt/module/flume
