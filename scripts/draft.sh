#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Invalid arguments"
  exit 1
fi

name=$1

hugo new "post/draft/$name.md"
mkdir -p "static/images/post/draft/$name"
