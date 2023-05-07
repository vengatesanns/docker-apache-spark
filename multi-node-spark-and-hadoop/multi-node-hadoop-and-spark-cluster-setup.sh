#!/bin/bash/
ARG1=$1
DOCKER_IMAGE_NAME=hackprotech/hadoop-and-spark-multinode-cluster:latest

buildDockerImage() {
  echo ">>>>>>>>>>>>>>>>>>>>>>>>> Building the Multi-node Hadoop and Spark Cluster Image"
  docker build -t $DOCKER_IMAGE_NAME .
  docker images
}

publishDockerImage() {
  echo ">>>>>>>>>>>>>>>>>>>>>>>>> Publishing the Multi-node Hadoop and Spark Cluster Image to Public Docker Hub"
  docker tag $DOCKER_IMAGE_NAME $DOCKER_IMAGE_NAME
  docker push $DOCKER_IMAGE_NAME
}

deployDockerImage() {
  echo ">>>>>>>>>>>>>>>>>>>>>>>>> Deploying the Multi-node Hadoop and Spark Cluster"
  docker compose up -d
}

rebuildDockerImage() {
  echo ">>>>>>>>>>>>>>>>>>>>>>>>> Rebuilding the Multi-node Hadoop and Spark Cluster"
  docker compose down
  docker rm -f hadoop-master hadoop-slave-1 hadoop-slave-2 spark-master spark-worker-1 spark-worker-2
  docker image rm -f $DOCKER_IMAGE_NAME
  docker build -t $DOCKER_IMAGE_NAME .
}

if [ "$ARG1" = "build" ]; then
  buildDockerImage
elif [ "$ARG1" = "deploy" ]; then
  deployDockerImage
elif [ "$ARG1" = "publish" ]; then
  publishDockerImage
elif [ "$ARG1" = "build_and_publish" ]; then
  buildDockerImage
  publishDockerImage
elif [ "$ARG1" = "build_and_deploy" ]; then
  buildDockerImage
  deployDockerImage
elif [ "$ARG1" = "rebuild_and_deploy" ]; then
  rebuildDockerImage
  deployDockerImage
else
  echo "Invalid Args $1"
fi
