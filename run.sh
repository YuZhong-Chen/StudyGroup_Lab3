#!/bin/bash

DOCKERFILE=Dockerfile
IMAGE_NAME=pytorch_test
CONTAINER_NAME=pytorch_test
MOUNT_PATH=./code
MOUNT_FOLDER=~/code

# remove old containers
docker ps -a | grep $IMAGE_NAME | awk '{print $1}' | xargs -r docker rm   

# remove old images
docker rmi $IMAGE_NAME

# build docker
docker build -t $IMAGE_NAME -f $DOCKERFILE .

# run docker
docker run \
    -it \
    --gpus all \
    --network host \
    --name $CONTAINER_NAME \
    --volume $MOUNT_PATH:$MOUNT_FOLDER \
    $IMAGE_NAME