FROM centos:7
RUN set -ex && \
    yum install -y epel-release && \
    yum install -y sudo tini openssh-server net-tools vim psmisc pdsh nc rsync lrzsz libzstd openssl-static git iputils-ping jq libfreetype6 fonts-dejavu fontconfig && \
    yum clean all && \
    ssh-keygen -A && \
    mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup && \
    curl -Lo /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo && \
    mv /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repo.backup && \
    mv /etc/yum.repos.d/epel-testing.repo /etc/yum.repos.d/epel-testing.repo.backup && \
    curl -Lo /etc/yum.repos.d/epel.repo https://mirrors.aliyun.com/repo/epel-7.repo && \
    sed -i -e '/mirrors.cloud.aliyuncs.com/d' -e '/mirrors.aliyuncs.com/d' /etc/yum.repos.d/CentOS-Base.repo && \
    sed '/^Host/a\ \ \ \ \ \ \ \ StrictHostKeyChecking no' /etc/ssh/ssh_config && \
    ssh-keygen -t rsa -N '' -q -f /root/.ssh/id_rsa && \
    cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys && \
    chmod 600 /root/.ssh/authorized_keys && \
    useradd atguigu && \
    echo "root:1" | chpasswd && \
    echo "atguigu:1" | chpasswd && \
    su - atguigu -c "ssh-keygen -t rsa -N '' -q -f /home/atguigu/.ssh/id_rsa && cat .ssh/id_rsa.pub >> .ssh/authorized_keys" && \
    chmod 600 /home/atguigu/.ssh/authorized_keys && \
    usermod -aG wheel atguigu && \
    sed -i -e '/^\%wheel/s/^/#/' -e '/^# \%wheel/s/^# //' /etc/sudoers && \
    mkdir /opt/software /opt/module && \
    chown -R atguigu:atguigu /opt/software /opt/module && \
    curl -L https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 -o /bin/ttyd && \
    chmod +x /bin/ttyd

COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

ENTRYPOINT [ "/bin/tini", "--" ]
CMD [ "/bin/entrypoint.sh" ]