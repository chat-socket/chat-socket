#!/bin/bash

# exit when any command fails
set -e

MODE="https"
BRANCH=main
BUILD=false
VERSION=1.0.0
POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -s|--ssh-mode)
    MODE="ssh"
    shift # past argument
    ;;
    -db|--docker-build)
    BUILD=true
    shift # past argument
    ;;
    -b|--branch)
    BRANCH="$2"
    shift # past argument
    shift # past value
    ;;
    -v|--version)
    VERSION="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

if [[ "$MODE" == "https" ]]; then
     GIT_HOST="https://github.com/chat-socket"
else
     GIT_HOST="git@github.com:chat-socket"
fi


init_project() {
    echo "Initialising $GIT_HOST/$1.git"
    if [ ! -d "$1" ]; then
        git clone "$GIT_HOST/$1.git" "$1"
        cd "$1"
        git checkout $BRANCH
        cd ..
    else
        cd "$1"
        git remote set-url origin "$GIT_HOST/$1.git"
        git checkout $BRANCH
        cd ..
    fi

    if [ "$BUILD" = true ] ; then
        cd "$1"
        ./build.sh -v "$VERSION" "${POSITIONAL[@]}"
        cd ..
    fi
}

mkdir -p src && cd src

init_project "user-management-service"
init_project "identity-authorization-server"
init_project "gateway-server"
init_project "messaging-service"
init_project "websocket-server"
init_project "web-frontend"