#!/bin/bash/
ARG1=$1

if [ $ARG1 == "start" ]
then
    echo ">>>>>>>>>>>>>>>>>>>>>>>>> Starting the Multi-node Hadoop Cluster"
    docker image rm -f hackprotech/multinode-apache-hadoop:1.0.0
    docker build -t hackprotech/multinode-apache-hadoop:1.0.0 .
    docker compose up -d
    docker logs master-node
elif [ $ARG1 ==  "stop" ]
then
    echo ">>>>>>>>>>>>>>>>>>>>>>>>> Stopping the Multi-node Hadoop Cluster"
    docker compose down
    docker rm -f master-node
elif [ $ARG1 ==  "rebuild" ]
then
    echo ">>>>>>>>>>>>>>>>>>>>>>>>> Rebuilding the Multi-node Hadoop Cluster"
    docker compose down
    docker rm -f master-node
    docker image rm -f hackprotech/multinode-apache-hadoop:1.0.0
    docker build -t hackprotech/multinode-apache-hadoop:1.0.0 .
    docker compose up -d
    docker logs master-node
else
   echo "Invalid Args $1"
fi