#!/bin/bash

set -ex

# 启动sshd
/sbin/sshd

# 执行初始化脚本
if ! [ -e /root/.init/READY ]; then
  for shc in /root/.init/*.sh; do
    [[ -e "${shc}" ]] || break
    bash "${shc}"
  done
  touch /root/.init/READY
fi

# 启动ttyd
/bin/ttyd su - atguigu
