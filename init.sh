#!/bin/bash

MODE="https"
BRANCH=main
POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -s|--ssh-mode)
    MODE="ssh"
    shift # past argument
    ;;
    -b|--branch)
    BRANCH="$2"
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
        git checkout $BRANCH
    else
        cd "$1"
        git remote set-url origin "$GIT_HOST/$1.git"
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