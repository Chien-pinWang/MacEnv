#!/usr/bin/env sh
cd ~/.env
dt=$(date '+%m/%d/%Y %H:%M:%S')
git add .
git commit -m "$dt> Maintenance sync to git remote"
git checkout master
git merge develop
git push origin master
git checkout develop
