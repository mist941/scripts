#!/bin/bash

SOURCE_FILE_PATH=''
DESTINATION_DIRECTORY_PATH=''

while getopts "s:d" opt; do
  case $opt in
    s)
      SOURCE_FILE_PATH=$OPTARG
      ;;
    d)
      DESTINATION_DIRECTORY_PATH=$OPTARG
      ;;
  esac
done