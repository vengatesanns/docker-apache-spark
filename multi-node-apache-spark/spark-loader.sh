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
if [ $SPARK_NODE == "MASTER" ]
then
    HOST_MACHINE_IP_ADDRESS=$(hostname -i)
    echo "SPARK_MASTER_IP=$HOST_MACHINE_IP_ADDRESS" >> spark-3.1.2-bin-hadoop2.7/conf/spark-env.sh
    echo "SPARK_MASTER_NODE - $SPARK_NODE"
    ./spark-3.1.2-bin-hadoop2.7/sbin/start-master.sh
elif  [ $SPARK_NODE == "WORKER" ]
then
    HOST_MACHINE_IP_ADDRESS=$(ping spark-master -c1 | head -1 | grep -Eo '[0-9.]{4,}')
    echo "SPARK_MASTER_IP=$HOST_MACHINE_IP_ADDRESS" >> spark-3.1.2-bin-hadoop2.7/conf/spark-env.sh
    echo "SPARK_WORKER_NODE - $SPARK_NODE"
    ./spark-3.1.2-bin-hadoop2.7/sbin/start-worker.sh $SPARK_MASTER_URL
else
    echo "Invalid SPARK_NODE - $SPARK_NODE"
fi

tail -f /dev/null