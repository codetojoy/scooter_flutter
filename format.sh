#!/bin/bash

set -e

if [ -n "$1" ]; then
  MY_FILE=$1
  stat ./lib/$MY_FILE > /dev/null 2>&1
  flutter format ./lib/$MY_FILE
else
  flutter format lib
  flutter format test
fi

echo "Ready."
