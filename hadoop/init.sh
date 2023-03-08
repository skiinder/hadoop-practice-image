#!/bin/bash
set -ex
if [ "$HOSTNAME" = "hadoop102" ]; then
  su - atguigu -c "hdfs namenode -format -nonInteractive"
fi