#!/bin/bash
xcall "/opt/module/zookeeper/bin/zkServer.sh $* 2>/dev/null" | grep -v Client