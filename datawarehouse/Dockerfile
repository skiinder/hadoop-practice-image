FROM registry.cn-zhangjiakou.aliyuncs.com/atguigu-practice/base-centos as source
COPY applog /opt/module/applog
COPY datax-config-generator /opt/module/datax-config-generator
COPY table-create-sql /opt/module/table-create-sql
COPY flume /opt/module/flume-temp
COPY scripts /home/atguigu/bin-temp
RUN chmod +x /home/atguigu/bin-temp/* && \
    chown -R atguigu:atguigu /opt/module && \
    chown -R atguigu:atguigu /home/atguigu/bin-temp

FROM registry.cn-zhangjiakou.aliyuncs.com/atguigu-practice/practice
COPY --from=source --chown=atguigu:atguigu /opt/module/applog /opt/module/applog
COPY --from=source --chown=atguigu:atguigu /opt/module/datax-config-generator /opt/module/datax-config-generator
COPY --from=source --chown=atguigu:atguigu /opt/module/table-create-sql /opt/module/table-create-sql
COPY --from=source --chown=atguigu:atguigu /opt/module/flume-temp /opt/module/flume
COPY --from=source --chown=atguigu:atguigu /home/atguigu/bin-temp /home/atguigu/bin
