FROM centos:7
RUN set -ex && \
    yum install -y epel-release && \
    yum install -y sudo tini openssh-server net-tools vim psmisc pdsh nc rsync lrzsz libzstd openssl-static git iputils-ping jq libfreetype6 fonts-dejavu fontconfig glibc-common kde-l10n-Chinese && \
    curl -LO https://downloads.mysql.com/archives/get/p/23/file/mysql-community-client-8.0.31-1.el7.x86_64.rpm && \
    curl -LO https://downloads.mysql.com/archives/get/p/23/file/mysql-community-client-plugins-8.0.31-1.el7.x86_64.rpm && \
    curl -LO https://downloads.mysql.com/archives/get/p/23/file/mysql-community-common-8.0.31-1.el7.x86_64.rpm && \
    curl -LO https://downloads.mysql.com/archives/get/p/23/file/mysql-community-libs-8.0.31-1.el7.x86_64.rpm && \
    curl -LO https://downloads.mysql.com/archives/get/p/23/file/mysql-community-libs-compat-8.0.31-1.el7.x86_64.rpm && \
    yum install -y *.rpm && \
    rm -rf *.rpm && \
    yum clean all && \
    mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup && \
    curl -Lo /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo && \
    mv /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repo.backup && \
    mv /etc/yum.repos.d/epel-testing.repo /etc/yum.repos.d/epel-testing.repo.backup && \
    curl -Lo /etc/yum.repos.d/epel.repo https://mirrors.aliyun.com/repo/epel-7.repo && \
    sed -i -e '/mirrors.cloud.aliyuncs.com/d' -e '/mirrors.aliyuncs.com/d' /etc/yum.repos.d/CentOS-Base.repo && \
    localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8 && \
    echo 'LANG="zh_CN.UTF-8"' > /etc/locale.conf && \
    echo 'export LANG="zh_CN.utf8"' > /etc/profile.d/language.sh && \
    ssh-keygen -A && \
    sed -i '/^Host/a\ \ \ \ \ \ \ \ StrictHostKeyChecking no' /etc/ssh/ssh_config && \
    ssh-keygen -t rsa -N '' -q -f /root/.ssh/id_rsa && \
    cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys && \
    sed -i 's/^#UseDNS yes/UseDNS no/' /etc/ssh/sshd_config && \
    chmod 600 /root/.ssh/authorized_keys && \
    useradd atguigu && \
    echo "root:1" | chpasswd && \
    echo "atguigu:1" | chpasswd && \
    su - atguigu -c "ssh-keygen -t rsa -N '' -q -f /home/atguigu/.ssh/id_rsa && cat .ssh/id_rsa.pub >> .ssh/authorized_keys; mkdir /home/atguigu/bin" && \
    chmod 600 /home/atguigu/.ssh/authorized_keys && \
    usermod -aG wheel atguigu && \
    sed -i -e '/^\%wheel/s/^/#/' -e '/^# \%wheel/s/^# //' /etc/sudoers && \
    mkdir /opt/software /opt/module && \
    chown -R atguigu:atguigu /opt/software /opt/module && \
    curl -L https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 -o /bin/ttyd && \
    chmod +x /bin/ttyd && \
    curl -L https://gist.githubusercontent.com/skiinder/6d59f36f4cb083ad2370b834f39351e5/raw/e8958e43ceda6328ced4c808ee21270c2b3f6d0e/xcall -o /bin/xcall && \
    chmod +x /bin/xcall && \
    curl -L https://gist.githubusercontent.com/skiinder/6d59f36f4cb083ad2370b834f39351e5/raw/e8958e43ceda6328ced4c808ee21270c2b3f6d0e/xsync -o /bin/xsync && \
    chmod +x /bin/xsync && \
    mkdir -p /root/.init

COPY  --chmod=755 entrypoint.sh /root/entrypoint.sh
EXPOSE 22 7681
ENTRYPOINT [ "/bin/tini", "--" ]
CMD [ "/root/entrypoint.sh" ]