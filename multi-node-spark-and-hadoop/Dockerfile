#  Multinode Spark and Hadoop
FROM hackprotech/spark-multinode-cluster:latest

ADD spark-hadoop-loader.sh /home/bigdata/
ADD hadoop_configs /home/bigdata/
RUN chmod +x /home/bigdata/spark-hadoop-loader.sh
RUN mkdir -p /home/bigdata/HDFS/namenode
RUN mkdir -p /home/bigdata/HDFS/datanode

#  Download and Extract the Apache Hadoop
RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz
RUN tar -xvf hadoop-2.7.7.tar.gz
RUN rm hadoop-2.7.7.tar.gz

RUN cp hadoop-2.7.7/etc/hadoop/mapred-site.xml.template hadoop-2.7.7/etc/hadoop/mapred-site.xml 

# Replace the Configuration Tag
RUN sed -i "/<configuration>/,/<\/configuration>/d " \
    hadoop-2.7.7/etc/hadoop/core-site.xml \
    hadoop-2.7.7/etc/hadoop/hdfs-site.xml \
    hadoop-2.7.7/etc/hadoop/mapred-site.xml \
    hadoop-2.7.7/etc/hadoop/yarn-site.xml

# 1. core-site.xml
RUN cat core-site.txt >> hadoop-2.7.7/etc/hadoop/core-site.xml

# 2. hdfs-site.xml
RUN cat hdfs-site.txt >> hadoop-2.7.7/etc/hadoop/hdfs-site.xml

# 3. mapred-site.xml
RUN cat mapred-site.txt >> hadoop-2.7.7/etc/hadoop/mapred-site.xml

# 4. yarn-site.xml
RUN cat yarn-site.txt >> hadoop-2.7.7/etc/hadoop/yarn-site.xml

RUN rm -r core-site.txt hdfs-site.txt mapred-site.txt yarn-site.txt

RUN echo "export JAVA_HOME=/home/bigdata/openlogic-openjdk-8u262-b10-linux-64" >> hadoop-2.7.7/etc/hadoop/hadoop-env.sh


ENTRYPOINT [ "./spark-hadoop-loader.sh" ]