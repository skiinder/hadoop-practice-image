FROM registry.cn-zhangjiakou.aliyuncs.com/atguigu-practice/kafka
RUN rm -rf /root/.init/03_hive.sh
COPY init.sh /root/.init/05_flume-practice-02.sh
COPY env.sh /etc/profile.d/flume-practice-02.sh
COPY --chown=atguigu:atguigu flume.conf /opt/module/flume/conf/flume.conf
