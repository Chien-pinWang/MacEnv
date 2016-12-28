#!/usr/bin/env sh

# TODO: Add log to capture any messages spitted from git

REPO='/Users/cpw/.env'
LOG='/Users/cpw/tmp/gitup.log'
COMMIT_TIMESTAMP=`date '+%m/%d/%Y %H:%M:%S'`
ORIGIN='https://Chien-pinWang:kaohGithub4512@github.com/Chien-pinWang/MacEnv.git'

GIT=`which git`

cd ${REPO}
${GIT} add . >> ${LOG}
${GIT} commit -m "${COMMIT_TIMESTAMP}> Maintenance sync to git remote" >> ${LOG}
${GIT} checkout master >> ${LOG}
${GIT} merge develop >> ${LOG}
${GIT} push ${ORIGIN} master >> ${LOG}
${GIT} checkout develop >> ${LOG}
