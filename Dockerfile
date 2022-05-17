
#  Ubuntu OS
FROM ubuntu

# Update and Upgrade the ubuntu OS
RUN apt-get -y update && apt-get -y upgrade
RUN apt install -y wget

# Make Dir
RUN mkdir /home/bigdata/

# Download OpenJDK Java 
RUN wget https://builds.openlogic.com/downloadJDK/openlogic-openjdk/8u262-b10/openlogic-openjdk-8u262-b10-linux-x64.tar.gz
# Download the Spark file
RUN wget https://dlcdn.apache.org/spark/spark-3.1.2/spark-3.1.2-bin-hadoop2.7.tgz

RUN tar -xvf openlogic-openjdk-8u262-b10-linux-x64.tar.gz
RUN tar -xvf spark-3.1.2-bin-hadoop2.7.tgz
RUN rm openlogic-openjdk-8u262-b10-linux-x64.tar.gz
RUN rm spark-3.1.2-bin-hadoop2.7.tgz
RUN cp -r openlogic-openjdk-8u262-b10-linux-64/ spark-3.1.2-bin-hadoop2.7/ /home/bigdata/

WORKDIR /home/bigdata/

RUN export JAVA_HOME=/home/bigdata/openlogic-openjdk-8u262-b10-linux-64
RUN export PATH=$PATH:$JAVA_HOME/bin

# Install and Set the sss-server and ssh-client
RUN apt-get install -y openssh-server openssh-client
RUN /etc/init.d/ssh start
RUN ssh-keygen -t rsa -P "" -f /root/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# CMD spark-3.1.2-bin-hadoop2.7/sbin/start-all.sh

ENTRYPOINT ["tail", "-f", "/dev/null"]
