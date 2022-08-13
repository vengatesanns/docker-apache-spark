
#  Ubuntu OS
FROM ubuntu

# Update and Upgrade the ubuntu OS
RUN apt-get -y update && apt-get -y upgrade
RUN apt install -y wget
RUN apt install -y iputils-ping

# Make Dir
RUN mkdir /home/bigdata/
WORKDIR /home/bigdata/

#  Download and Extract the Apache Hadoop
RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz
RUN tar -xvf hadoop-2.7.7.tar.gz
RUN rm hadoop-2.7.7.tar.gz

# Download OpenJDK Java 1.8
RUN wget https://builds.openlogic.com/downloadJDK/openlogic-openjdk/8u262-b10/openlogic-openjdk-8u262-b10-linux-x64.tar.gz
RUN tar -xvf openlogic-openjdk-8u262-b10-linux-x64.tar.gz
RUN rm openlogic-openjdk-8u262-b10-linux-x64.tar.gz


# Install and Set the sss-server and ssh-client
RUN apt-get install -y openssh-server openssh-client
RUN ssh-keygen -t rsa -P "" -f /root/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys


ADD hadoop-loader.sh ./
COPY hadoop_configs ./
COPY hadoop_configs/master ./
COPY hadoop_configs/slave ./
RUN chmod +x /home/bigdata/hadoop-loader.sh

RUN mkdir -p /home/bigdata/HDFS/namenode
RUN mkdir -p /home/bigdata/HDFS/datanode

RUN cp hadoop-2.7.7/etc/hadoop/mapred-site.xml.template hadoop-2.7.7/etc/hadoop/mapred-site.xml 

# Replace the Configuration Tag
RUN sed -i "/<configuration>/,/<\/configuration>/d " \
    hadoop-2.7.7/etc/hadoop/core-site.xml \
    # hadoop-2.7.7/etc/hadoop/hdfs-site.xml \
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

RUN echo "export JAVA_HOME=/home/bigdata/openlogic-openjdk-8u262-b10-linux-64" >> hadoop-2.7.7/etc/hadoop/hadoop-env.sh

ENTRYPOINT [ "./hadoop-loader.sh" ]