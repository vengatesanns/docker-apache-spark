# Apache Spark in Docker

1. **_docker tag hackprotech/spark-multinode-cluster:latest hackprotech/spark-multinode-cluster:latest_**
2. **_docker push hackprotech/spark-multinode-cluster:latest_**

spark-3.1.2-bin-hadoop2.7/bin/spark-submit \
 --master spark://spark-master:7077 \
 --class com.hackprotech.SparkClusterWithStandaloneCluster \
 --executor-memory 1GB \
 --num-executors 5 \
 spark-realtime-projects-assembly-3.0.0.jar

# Apache Hadoop in Docker

1. **_docker tag hackprotech/hadoop-multinode-cluster:latest hackprotech/hadoop-multinode-cluster:latest_**
2. **_docker push hackprotech/hadoop-multinode-cluster:latest_**

# List Excluded Ports in Windows

> netsh interface ipv4 show excludedportrange protocol=tcp
