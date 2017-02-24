#!/usr/bin/env sh

# TODO: 

REPO='/Users/cpw/.env'
LOG='/Users/cpw/tmp/gitup.log'
COMMIT_TIMESTAMP=`date '+%m/%d/%Y %H:%M:%S'`
ORIGIN='https://Chien-pinWang:kaohGithub4512@github.com/Chien-pinWang/MacEnv.git'

GIT=`which git`

echo "Maintenance Sync at ${COMMIT_TIMESTAMP}" >> ${LOG} 2>&1
cd ${REPO} >> ${LOG} 2>&1
${GIT} add . >> ${LOG} 2>&1
${GIT} commit -m "${COMMIT_TIMESTAMP}> Maintenance sync" >> ${LOG} 2>&1
${GIT} checkout master >> ${LOG} 2>&1
${GIT} merge develop >> ${LOG} 2>&1
${GIT} push ${ORIGIN} master >> ${LOG} 2>&1
${GIT} checkout develop >> ${LOG} 2>&1
