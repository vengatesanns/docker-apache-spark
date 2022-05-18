#!/bin/bash

# Settings ENV in .bashrc file
echo "export JAVA_HOME=/home/bigdata/openlogic-openjdk-8u262-b10-linux-64" >> /root/.bashrc
echo "export PATH=$PATH:/home/bigdata/openlogic-openjdk-8u262-b10-linux-64/bin" >> /root/.bashrc
source /root/.bashrc
echo ">>>>>>> Setting ENV variables done..."

# Start the ssh server
echo ">>>>>> Starting the SSH server..."
/etc/init.d/ssh start

echo ">>>>>> Starting the Apache Spark..."
./spark-3.1.2-bin-hadoop2.7/sbin/start-all.sh

tail -f /dev/null