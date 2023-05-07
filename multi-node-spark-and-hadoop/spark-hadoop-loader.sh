#!/bin/bash

# Settings ENV in .bashrc file
echo "export JAVA_HOME=/home/bigdata/openlogic-openjdk-8u262-b10-linux-64" >>/root/.bashrc
echo "export PATH=$PATH:/home/bigdata/openlogic-openjdk-8u262-b10-linux-64/bin" >>/root/.bashrc
source /root/.bashrc
echo ">>>>>>> Setting ENV variables done..."

# Start the ssh server
/etc/init.d/ssh start
echo ">>>>>> SSH Server Started Successfully..."

# Start the Master and Worker based on the env params condition
echo " StrictHostKeyChecking no" >>~/.ssh/config

# Delete the configuration tag in xml
sed -i "/<configuration>/,/<\/configuration>/d " hadoop-2.7.7/etc/hadoop/hdfs-site.xml

MASTER_NODE="master-node"

if [ "$NODE_TYPE" = "MASTER" ]; then
  echo ">>>>>> Starting the Multinode Hadoop Cluster - MASTER NODE..."
  rm hadoop-2.7.7/etc/hadoop/slaves
  touch slaves
  echo "slave-node-1" >>hadoop-2.7.7/etc/hadoop/slaves
  echo "slave-node-2" >>hadoop-2.7.7/etc/hadoop/slaves
  cat /home/bigdata/hdfs-site-master.txt >>hadoop-2.7.7/etc/hadoop/hdfs-site.xml
  hadoop-2.7.7/bin/hdfs namenode -format
  hadoop-2.7.7/sbin/start-all.sh
  echo ">>>>> Hadoop Master Started Successfully!"

  echo ">>>>>> Starting the Multinode Spark Cluster - MASTER NODE..."
  HOST_MACHINE_IP_ADDRESS=$(hostname -i)
  echo "SPARK_MASTER_IP=$HOST_MACHINE_IP_ADDRESS" >>spark-3.1.2-bin-hadoop2.7/conf/spark-env.sh
  ./spark-3.1.2-bin-hadoop2.7/sbin/start-master.sh
  echo ">>>>> Spark Master Started Successfully!"

elif [ "$NODE_TYPE" = "SLAVE" ]; then
  echo ">>>>> Starting Hadoop Slave Node - $NODE_NUM..."
  cat /home/bigdata/hdfs-site-slave.txt >>hadoop-2.7.7/etc/hadoop/hdfs-site.xml
  echo ">>>>> Hadoop Slave Node - $NODE_NUM Started Successfully"

  echo ">>>>> Starting Spark Slave Node - $NODE_NUM..."
  HOST_MACHINE_IP_ADDRESS=$(ping $MASTER_NODE -c1 | head -1 | grep -Eo '[0-9.]{4,}')
  echo "SPARK_MASTER_IP=$HOST_MACHINE_IP_ADDRESS" >>spark-3.1.2-bin-hadoop2.7/conf/spark-env.sh
  ./spark-3.1.2-bin-hadoop2.7/sbin/start-worker.sh $SPARK_MASTER_URL
  echo ">>>>> Spark Slave Node - $NODE_NUM Started Successfully"
else
  echo "Invalid HADOOP NODE_TYPE - $NODE_TYPE"
fi

tail -f /dev/null
