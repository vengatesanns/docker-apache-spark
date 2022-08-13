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


# Delete the configuration tag in xml
sed -i "/<configuration>/,/<\/configuration>/d " hadoop-2.7.7/etc/hadoop/hdfs-site.xml

if [ $NODE_TYPE == "MASTER" ]
then
    echo "slave-node-1" >> hadoop-2.7.7/etc/hadoop/slaves
    echo "slave-node-2" >> hadoop-2.7.7/etc/hadoop/slaves
    cat /home/bigdata/hdfs-site-master.txt >> hadoop-2.7.7/etc/hadoop/hdfs-site.xml

    hadoop-2.7.7/bin/hdfs namenode -format
elif  [ $NODE_TYPE == "SLAVE1" ]
then    
    # mkdir -p /home/bigdata/HDFS/datanode
    cat /home/bigdata/hdfs-site-slave.txt >> hadoop-2.7.7/etc/hadoop/hdfs-site.xml
elif  [ $NODE_TYPE == "SLAVE2" ]
then
    # mkdir -p /home/bigdata/HDFS/datanode
    # echo "slave-node-2" >> hadoop-2.7.7/etc/hadoop/slaves
    cat /home/bigdata/hdfs-site-slave.txt >> hadoop-2.7.7/etc/hadoop/hdfs-site.xml
else
    echo "Invalid NODE_TYPE - $NODE_TYPE"
fi


hadoop-2.7.7/sbin/start-all.sh

tail -f /dev/null