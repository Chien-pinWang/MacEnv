#!/usr/bin/env sh

REPO='/Users/cpw/.env'
COMMIT_TIMESTAMP=`date '+%m/%d/%Y %H:%M:%S'`
ORIGIN='https://Chien-pinWang:kaohGithub4512@github.com/Chien-pinWang/MacEnv.git'

GIT=`which git`

cd ${REPO}
${GIT} add .
${GIT} commit -m "${COMMIT_TIMESTAMP}> Maintenance sync to git remote"
${GIT} checkout master
${GIT} merge develop
${GIT} push ${ORIGIN} master
${GIT} checkout develop
