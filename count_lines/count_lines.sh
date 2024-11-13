#!/bin/bash

file_path=""
file_name=""

while getopts "f:" opt; do
  case $opt in
    f)
      file_path=$(dirname "$OPTARG")
      file_name=$(basename "$OPTARG")
      ;;
  esac
done

if [[ -z "$file_path" ]] || [[ -z "$file_name" ]]; then
  echo "File is required"
  exit 1
fi

cat "${file_path}/${file_name}" | wc -l 