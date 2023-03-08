#!/bin/bash
xcall "zkServer.sh $* 2>/dev/null" | grep -v Client