#!/bin/sh

if [ $# -ne 2 ]; then
  echo "Invalid arguments"
  exit 1
fi

date=$1
name=$2

mkdir -p "content/post/$date"
if [ -e "content/post/draft/$name.md" ]; then
  mv "content/post/draft/$name.md" "content/post/$date/"
fi

images=$(grep "img_rel" "content/post/$date/$name.md")
if [ "$images" ] && [ -d "static/images/post/draft/$name" ]; then
  mkdir -p "static/images/post/$date/$name"
  mv "static/images/post/draft/$name" "static/images/post/$date/"
fi

if [ -d "static/images/post/draft/$name" ]; then
  if [ -z "static/images/post/draft/$name" ]; then
    :
  else
    rm -r "static/images/post/draft/$name"
  fi
fi

hugo undraft "content/post/$date/$name.md"
