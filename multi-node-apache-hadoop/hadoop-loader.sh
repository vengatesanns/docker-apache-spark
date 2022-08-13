#!/bin/bash

# Settings ENV in .bashrc file
echo "export JAVA_HOME=/home/bigdata/openlogic-openjdk-8u262-b10-linux-64" >> /root/.bashrc
echo "export PATH=$PATH:/home/bigdata/openlogic-openjdk-8u262-b10-linux-64/bin" >> /root/.bashrc
source /root/.bashrc
echo ">>>>>>> Setting ENV variables done..."

# Start the ssh server
echo ">>>>>> Starting the SSH server..."
/etc/init.d/ssh start

# Start the Master and Worker based on the env params condition
echo ">>>>>> Starting the Apache Spark..."
if [ $NODE_TYPE == "MASTER" ]
then
    ./hadoop-2.7.7/sbin/start-all.sh
elif  [ $NODE_TYPE == "WORKER" ]
then
    echo "sadasd"
else
    echo "Invalid NODE_TYPE - $NODE_TYPE"
fi

tail -f /dev/null