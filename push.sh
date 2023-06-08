#!/bin/sh

git add .
git commit -S -m "Update: $(date)"
git push origin master
