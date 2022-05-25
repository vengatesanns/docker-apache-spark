# Apache Spark in Docker

> ***docker tag hackprotech/apache-spark:1.2.0 hackprotech/apache-spark:1.2.0***
> ***docker push hackprotech/apache-spark:1.2.0***


spark-3.1.2-bin-hadoop2.7/bin/spark-submit \
        --master spark://spark-master:7077 \
        --class com.hackprotech.SparkClusterWithStandaloneCluster \
        --executor-memory 1GB \
        --num-executors 5 \
        spark-realtime-projects-assembly-3.0.0.jar


