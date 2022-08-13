#!/bin/bash

ssh-keygen -R hostname

# Settings ENV in .bashrc file
echo "export JAVA_HOME=/home/bigdata/openlogic-openjdk-8u262-b10-linux-64" >> /root/.bashrc
echo "export PATH=$PATH:/home/bigdata/openlogic-openjdk-8u262-b10-linux-64/bin" >> /root/.bashrc
source /root/.bashrc
echo ">>>>>>> Setting ENV variables done..."

# Start the ssh server
echo ">>>>>> Starting the SSH server..."
/etc/init.d/ssh start

# Start the Master and Worker based on the env params condition
echo ">>>>>> Starting the Apache Hadoop..."
echo " StrictHostKeyChecking no" >> ~/.ssh/config
if [ $NODE_TYPE == "MASTER" ]
then
    echo "slave-node-1" >> hadoop-2.7.7/etc/hadoop/slaves
    echo "slave-node-2" >> hadoop-2.7.7/etc/hadoop/slaves
    hadoop-2.7.7/bin/hdfs namenode -format
elif  [ $NODE_TYPE == "SLAVE1" ]
then
        echo "slave-node-1" >> hadoop-2.7.7/etc/hadoop/slaves
elif  [ $NODE_TYPE == "SLAVE2" ]
then
        echo "slave-node-2" >> hadoop-2.7.7/etc/hadoop/slaves
else
    echo "Invalid NODE_TYPE - $NODE_TYPE"
fi


hadoop-2.7.7/sbin/start-all.sh

tail -f /dev/null