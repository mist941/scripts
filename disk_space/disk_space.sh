#!/bin/bash

usage_in_percents=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

if [[ $? -ne 0 ]]; then
    echo "Error: Failed to retrieve disk usage information."
    exit 1
fi

# Перевіряємо рівень зайнятого простору
if (( usage_in_percents >= 80 )); then
    echo "Warning: Disk space usage is ${usage_in_percents}%, which exceeds the limit!"
else
    echo "All good: Disk space usage is ${usage_in_percents}%."
fi