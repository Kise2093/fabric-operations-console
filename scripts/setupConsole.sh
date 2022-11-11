#!/bin/bash

SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" # Where the script lives

function networkUp() {
	#docker-compose -f ${SRC_DIR}/../docker/docker-compose-console.yaml up -d
	#docker-compose -f ${SRC_DIR}/../docker/docker-compose-grpc-web.yaml up -d
	oc -n blockchain apply -f ${SRC_DIR}/../docker/docker-kompose-console/.
	#oc -n blockchain apply -f ${SRC_DIR}/../docker/docker-kompose-grpc/.
}

function networkDown() {
	#docker-compose -f ${SRC_DIR}/../docker/docker-compose-console.yaml down
	#docker-compose -f ${SRC_DIR}/../docker/docker-compose-grpc-web.yaml down
	oc -n blockchain delete -f ${SRC_DIR}/../docker/docker-kompose-console/.
	oc -n blockchain delete -f ${SRC_DIR}/../docker/docker-kompose-grpc/.
}

function printHelp() {
 echo "./startConsole up"
 echo "./startConsole down"
}
## Parse mode
if [[ $# -lt 1 ]] ; then
  printHelp
  exit 0
else
  MODE=$1
  shift
fi

if [ "${MODE}" == "up" ]; then
  networkUp
elif [ "${MODE}" == "down" ]; then
  networkDown
else
  printHelp
  exit 1
fi
