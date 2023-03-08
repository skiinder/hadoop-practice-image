FROM registry.cn-zhangjiakou.aliyuncs.com/atguigu-practice/kafka as source

RUN curl -L https://github.com/skiinder/DataX/releases/download/20230107/datax.tar.gz | tar -zx --no-same-owner && \
    mv datax /opt/module/datax

RUN curl -L https://github.com/skiinder/maxwell/releases/download/230204/maxwell-1.29.2.tar.gz | tar -zx --no-same-owner && \
    mv maxwell-1.29.2 /opt/module/maxwell

COPY applog /opt/module/applog
COPY datax-config-generator /opt/module/datax-config-generator
COPY table-create-sql /opt/module/table-create-sql
COPY flume /opt/module/flume-temp
COPY maxwell /opt/module/maxwell
COPY scripts /home/atguigu/bin-temp
RUN chmod +x /home/atguigu/bin-temp/* && \
    chown -R atguigu:atguigu /opt/module && \
    chown -R atguigu:atguigu /home/atguigu/bin-temp

FROM registry.cn-zhangjiakou.aliyuncs.com/atguigu-practice/kafka
COPY --from=source --chown=atguigu:atguigu /opt/module/datax /opt/module/datax
COPY --from=source --chown=atguigu:atguigu /opt/module/maxwell /opt/module/maxwell
COPY --from=source --chown=atguigu:atguigu /opt/module/applog /opt/module/applog
COPY --from=source --chown=atguigu:atguigu /opt/module/datax-config-generator /opt/module/datax-config-generator
COPY --from=source --chown=atguigu:atguigu /opt/module/table-create-sql /opt/module/table-create-sql
COPY --from=source --chown=atguigu:atguigu /opt/module/flume-temp /opt/module/flume
COPY --from=source --chown=atguigu:atguigu /home/atguigu/bin-temp /home/atguigu/bin
