
#  Ubuntu OS + Apache Spark
FROM hackprotech/apache-spark:2.0.0

#  Download and Extract the Apache Hadoop
RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz
RUN tar -xvf hadoop-2.7.7.tar.gz
RUN rm hadoop-2.7.7.tar.gz

ADD hadoop-loader.sh /home/bigdata/
ADD hadoop-configs /home/bigdata/
RUN mkdir -p /home/bigdata/HDFS/namenode
RUN mkdir -p /home/bigdata/HDFS/datanode

WORKDIR /home/bigdata/

# Replace the Configuration Tag
RUN sed -i "/<configuration>/,/<\/configuration>/d " core-site.xml hdfs-site.xml mapred-site.xml yarn-site.xml

# 1. core-site.xml
RUN cat hadoop-configs/core-site.txt >> hadoop-2.7.7/etc/hadoop/core-site.xml

# 2. hdfs-site.xml
RUN cat hadoop-configs/hdfs-site.txt >> hadoop-2.7.7/etc/hadoop/hdfs-site.xml

# 3. mapred-site.xml
RUN cat hadoop-configs/mapred-site.txt >> hadoop-2.7.7/etc/hadoop/mapred-site.xml

# 4. yarn-site.xml
RUN cat hadoop-configs/yarn-site.txt >> hadoop-2.7.7/etc/hadoop/yarn-site.xml

RUN echo "export JAVA_HOME=/home/bigdata/openlogic-openjdk-8u262-b10-linux-64" >> hadoop-2.7.7/etc/hadoop/hadoop-env.sh


ENTRYPOINT [ "./hadoop-loader.sh" ]