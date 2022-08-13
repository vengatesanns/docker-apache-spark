
#  Ubuntu OS
FROM ubuntu

# Update and Upgrade the Alphine OS
RUN apt-get -y update && apt-get -y upgrade
RUN apt install -y wget
RUN apt install -y iputils-ping
RUN apt-get install -y openssh-server openssh-client

# Make Dir
RUN mkdir /home/bigdata/
WORKDIR /home/bigdata/


ADD spark_loader.sh ./
RUN chmod +x ./spark_loader.sh

# Download OpenJDK Java 1.8
RUN wget https://builds.openlogic.com/downloadJDK/openlogic-openjdk/8u262-b10/openlogic-openjdk-8u262-b10-linux-x64.tar.gz
# Download the Spark Framework
RUN wget https://archive.apache.org/dist/spark/spark-3.1.2/spark-3.1.2-bin-hadoop2.7.tgz

RUN tar -xvf openlogic-openjdk-8u262-b10-linux-x64.tar.gz
RUN tar -xvf spark-3.1.2-bin-hadoop2.7.tgz
RUN rm openlogic-openjdk-8u262-b10-linux-x64.tar.gz
RUN rm spark-3.1.2-bin-hadoop2.7.tgz


RUN cp spark-3.1.2-bin-hadoop2.7/conf/spark-env.sh.template spark-3.1.2-bin-hadoop2.7/conf/spark-env.sh
RUN echo "export JAVA_HOME=/home/bigdata/openlogic-openjdk-8u262-b10-linux-64" >> spark-3.1.2-bin-hadoop2.7/conf/spark-env.sh
RUN echo "SPARK_MASTER_HOST=spark-master" >> spark-3.1.2-bin-hadoop2.7/conf/spark-env.sh

RUN touch spark-3.1.2-bin-hadoop2.7/conf/workers.sh
RUN echo "spark-worker1" >> spark-3.1.2-bin-hadoop2.7/conf/workers.sh
RUN echo "spark-worker2" >> spark-3.1.2-bin-hadoop2.7/conf/workers.sh

# Install and Set the sss-server and ssh-client
RUN ssh-keygen -t rsa -P "" -f /root/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

ENTRYPOINT ["./spark_loader.sh"]