#!/bin/bash

exho "asdd"
hadoop-2.7.7/bin/hdfs namenode -format
hadoop-2.7.7/sbin/start-dfs.sh
jps



tail -f /dev/null