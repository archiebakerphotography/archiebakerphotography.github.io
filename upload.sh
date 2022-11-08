#!/bin/bash

# Script to commit and push changes to the website

# Set up config in case it hasn't been set yet
git config --global user.email "archiehowardbaker@gmail.com"
git config --global user.name "Archie Baker"

# Run auth command
git remote add origin https://github.com/archiebakerphotography/archiebakerphotography.github.io.git
gh auth login -p https -w


# Pull latest changes from the repo
git pull

# Commit all files in the images folder'
git add images/*

# Commit all added files
git commit -m "Update images"

# Push changes to the remote repository
git push origin master

# Should now generate serverside
echo "Done."

# Delay for 3 seconds then end script
sleep 3
