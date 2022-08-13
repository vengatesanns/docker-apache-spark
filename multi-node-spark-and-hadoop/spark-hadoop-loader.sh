#!/bin/bash

# Executing the Multinode Spark Cluster
echo ">>>>>> Starting the Multinode Spark Cluster..."
sh spark-loader.sh

# Executing the Multinode Hadoop Cluster
echo ">>>>>> Starting the Multinode Hadoop Cluster..."
sh hadoop-loader.sh

tail -f /dev/null