#!/bin/bash

imageName="dderesearch/main"

existingContainers=$(docker ps -a | grep $imageName | awk '{print $1}')
echo $existingContainers
if [[ -n $existingContainers ]]; then
	echo Found DDE containers. Stopping and removing them.
	docker stop $existingContainers >/dev/null
	docker rm $existingContainers >/dev/null
else 
	echo No existing DDE containers.
fi

if [ ! -z "$1" ] && [ $1 == "stop" ]; then
	echo Successfully stopped DDE containers
	exit 
fi 

echo Pulling down most recent image of $imageName
docker pull $imageName

successfulPull=$?

if [ $successfulPull != 0 ]; then
	echo ERROR: Unable to pull down the most recent image of $imageName
fi 

echo Starting up new DDE Docker Container:

docker run --rm -v "$(pwd)":/host/ -it  --entrypoint /bin/bash ddetest
