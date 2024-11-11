#!/bin/bash

source_file_path=""
destination_directory=""
year=$(date +"%Y")
month=$(date +"%m")
day=$(date +"%d")
time=$(date +"%H%M%S")
file_name=""
new_file_name=""

while getopts "s:d:" opt; do
  case $opt in
    s)
      source_file_path=$(dirname "$OPTARG")
      file_name=$(basename "$OPTARG")
      ;;
    d)
      destination_directory=$OPTARG
      ;;
  esac
done

if [[ -z "$source_file_path" ]]; then
  echo "Source file is required"
  exit 1
fi

if [[ -z "$destination_directory" ]]; then
  echo "Destination folder is required"
  exit 1
fi

new_file_name="${year}${month}${day}${time}_${file_name}"

cp "${source_file_path}/${file_name}" "${destination_directory}/${new_file_name}"