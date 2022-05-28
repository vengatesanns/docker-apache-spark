
#  Ubuntu OS + Apache Spark
FROM hackprotech/apache-spark:2.0.0

#  Download and Extract the Apache Hadoop
RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz
RUN tar -xvf hadoop-2.7.7.tar.gz
RUN rm hadoop-2.7.7.tar.gz

# RUN cp -r hadoop-2.7.7/ /home/bigdata/
ADD hadoop-loader.sh /home/bigdata/
RUN mkdir -p /home/bigdata/HDFS/namenode

WORKDIR /home/bigdata/

# 1. core-site.xml
RUN echo "<configuration> \
            <property> \
                <name>fs.defaultFS</name> \
                <value>hdfs://spark-master:9000</value> \
            </property> \
        </configuration>" >> hadoop-2.7.7/etc/hadoop/core-site.xml

# 2. hdfs-site.xml
RUN echo "<configuration> \
            <property> \
                <name>dfs.replication</name> \
                <value>1</value> \
            </property> \
            <property> \
                <name>dfs.namenode.name.dir</name> \
                <value>/home/bigdata/HDFS/namenode</value> \
            </property> \
        </configuration>" >> hadoop-2.7.7/etc/hadoop/hdfs-site.xml

# 3. mapred-site.xml
RUN echo "<configuration> \
            <property> \
                <name>mapreduce.framework.name</name> \
                <value>yarn</value> \
            </property> \
          </configuration>" >> hadoop-2.7.7/etc/hadoop/mapred-site.xml

# 4. yarn-site.xml
RUN echo "<configuration> \
            <property> \
                <name>yarn.nodemanager.aux-services</name> \
                <value>mapreduce_shuffle</value> \
            </property> \
            <property> \
                <name>yarn.nodemanager.auxservices.mapreduce.shuffle.class</name> \
                <value>org.apache.hadoop.mapred.ShuffleHandler</value> \
            </property> \
        </configuration>" >> hadoop-2.7.7/etc/hadoop/yarn-site.xml


ENTRYPOINT [ "./hadoop-loader.sh" ]