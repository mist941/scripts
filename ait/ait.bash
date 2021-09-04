#!/bin/bash

ACTUAL_DIRECTORY=$(pwd)

LOCAL_DIRECTORY=$(dirname $BASH_SOURCE)

USE_GIT='git --git-dir='$ACTUAL_DIRECTORY'/.git'

source "$LOCAL_DIRECTORY/config.cfg"

echo -e "\033[32mWhat do you want from me?"

read COMAND

function GET_REPO {
    read BRANCH
    if [ "$BRANCH" = "qa" ]; then
        echo "$QA_REPO"
    elif [ "$BRANCH" = "demo" ]; then
        echo "$DEMO_REPO"
    elif [ "$BRANCH" = "prod" ]; then
        echo "$PROD_REPO"
    fi
}

case "$COMAND" in
create)
    echo -e "\033[33mFrom:(qa/demo/prod)"
    FROM=$(GET_REPO)
    echo -e "\033[33mYour branch:"
    read BRANCH_NAME
    $USE_GIT checkout -b $BRANCH_NAME $FROM
    ;;
move)
    echo -e "\033[33mTo:(qa/demo/prod)"
    TO=$(GET_REPO)
    CURRENT_BRANCH=$($USE_GIT rev-parse --abbrev-ref HEAD)
    $USE_GIT pull --rebase origin $TO
    $USE_GIT push --set-upstream origin $CURRENT_BRANCH
    $USE_GIT checkout $TO
    $USE_GIT branch -d $CURRENT_BRANCH
    ;;
esac
