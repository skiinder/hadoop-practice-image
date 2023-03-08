FROM registry.cn-zhangjiakou.aliyuncs.com/atguigu-practice/base-centos as source
RUN curl -L https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u352-b08/OpenJDK8U-jdk_x64_linux_hotspot_8u352b08.tar.gz | tar -zx --no-same-owner && \
    mv jdk8u352-b08 /opt/module/java

RUN chown -R atguigu:atguigu /opt/module

FROM registry.cn-zhangjiakou.aliyuncs.com/atguigu-practice/base-centos
COPY --from=source --chown=atguigu:atguigu /opt/module/java /opt/module/java
COPY --chmod=755 jpsall /bin/jpsall
COPY env.sh /etc/profile.d/java.sh
