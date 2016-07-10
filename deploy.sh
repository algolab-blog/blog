#!/bin/sh
echo -e "Deploying updates to GitHub..."

# Clean up
rm -rf public/*

# Build the project.
hugo # if using a theme, replace by `hugo -t <yourtheme>`

# Go To Public folder
cd public

echo blog.algolab.jp > CNAME

# Add changes to git.
git add -A .

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push submodule repos
git push origin master

# Come Back
cd ..

# Push origin repos
git add -A .
git commit -m "$msg"
git push origin master
