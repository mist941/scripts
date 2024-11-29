#!/bin/bash

search_dir=""
prefix=""

while getopts "d:p:" opt; do
  case $opt in
    d)
      search_dir=$OPTARG
      ;;
    p)
      prefix=$OPTARG
      ;;
    *)
      echo "Usage: $0 -d <directory> -p <prefix>"
      exit 1
      ;;
  esac
done

if [[ -z "$search_dir" ]]; then
  echo "Error: you need to specify a directory using the -d flag"
  exit 1
elif [[ ! -d "$search_dir" ]]; then
  echo "Error: '${search_dir}' is nont a directory"
  exit 1
fi

if [[ -z "$prefix" ]]; then
  echo "Error: you need to specify a prefix using the -p flag"
  exit 1
fi

for entry in "$search_dir"/*; do
  if [[ -f "$entry" ]]; then
    file_path=$(dirname "$entry")
    file_name=$(basename "$entry")
    new_name="${file_path}/${prefix}${file_name}"

    if [[ -e "$new_name" ]]; then
      echo "Warning: '$new_name' already exists. Skipping."
      continue
    fi

    mv "$entry" "$new_name"
    echo "Renamed: '$entry' → '$new_name'"
  fi
done