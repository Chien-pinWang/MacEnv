#!/usr/bin/env sh
cd ~/.env
git commit -am "Maintenance sync to git remote"
git checkout master
git merge develop
git push origin master
git checkout develop
