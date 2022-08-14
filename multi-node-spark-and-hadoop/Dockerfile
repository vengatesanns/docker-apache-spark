#  Multinode Spark and Hadoop
FROM hackprotech/hadoop-multinode-cluster:latest


# Make Dir
WORKDIR /home/bigdata/

ADD spark-hadoop-loader.sh ./
RUN chmod +x ./spark-hadoop-loader.sh

# Download the Spark Framework
RUN wget https://archive.apache.org/dist/spark/spark-3.1.2/spark-3.1.2-bin-hadoop2.7.tgz

RUN tar -xvf spark-3.1.2-bin-hadoop2.7.tgz
RUN rm spark-3.1.2-bin-hadoop2.7.tgz


RUN cp spark-3.1.2-bin-hadoop2.7/conf/spark-env.sh.template spark-3.1.2-bin-hadoop2.7/conf/spark-env.sh
RUN echo "export JAVA_HOME=/home/bigdata/openlogic-openjdk-8u262-b10-linux-64" >> spark-3.1.2-bin-hadoop2.7/conf/spark-env.sh
RUN echo "SPARK_MASTER_HOST=master-node" >> spark-3.1.2-bin-hadoop2.7/conf/spark-env.sh

RUN touch spark-3.1.2-bin-hadoop2.7/conf/workers.sh
RUN echo "slave-node-1" >> spark-3.1.2-bin-hadoop2.7/conf/workers.sh
RUN echo "slave-node-2" >> spark-3.1.2-bin-hadoop2.7/conf/workers.sh

ENTRYPOINT ["./spark-hadoop-loader.sh"]
