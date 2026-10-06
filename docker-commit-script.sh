# ! /bin/bash

SERVICE=${1}
IMAGE=${2}

CONTAINER_ID=$(docker ps -aqf "name=${SERVICE}")

if [ ! -z "$CONTAINER_ID" ]; then
    echo "--- Committing changes from $SERVICE to $IMAGE ---"
    docker commit $CONTAINER_ID $IMAGE
fi
