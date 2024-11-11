#!/bin/bash

site_url=""
advanced_check=false

while getopts "s:a" opt; do
  case $opt in
    s)
      site_url=$OPTARG
      ;;
    a)
      advanced_check=true
      ;;
    *)
      echo "Usage: $0 -s <site_url> [-a]"
      echo "  -s: URL of the site you want to check."
      echo "  -a: Perform an advanced check (HTTP code + response time)."
      exit 1
      ;;
  esac
done

if [[ -z "$site_url" ]]; then
  echo "Error: The site URL is not specified."
  echo "Usage: $0 -s <site_url> [-a]"
  exit 1
fi

if [[ "$advanced_check" == true ]]; then
    curl -I ${site_url}
else
    curl -o /dev/null -s -w "%{http_code}\n" ${site_url}  
fi
