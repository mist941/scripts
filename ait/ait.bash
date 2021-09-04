#!/bin/bash

ACTUAL_DIRECTORY=$(pwd)

LOCAL_DIRECTORY=$(dirname $BASH_SOURCE)

USE_GIT='git --git-dir='$ACTUAL_DIRECTORY'/.git'

source "$LOCAL_DIRECTORY/config.cfg"

echo -e "\033[32mWhat do you want from me?"

read COMAND

function GET_REPO {
    read BRANCH
    if [ "$BRANCH" = "$QA_REPO" ]; then
        return $(($QA_REPO))
    elif [ "$BRANCH" = "$DEMO_REPO" ]; then
        return $(($DEMO_REPO))
    elif [ "$BRANCH" = "$PROD_REPO" ]; then
        return $(($PROD_REPO))
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
    $USE_GIT push $TO $CURRENT_BRANCH
    $USE_GIT branch -D $CURRENT_BRANCH
    ;;
esac
