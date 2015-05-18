#!/bin/bash

# SHELL=/bin/sh
# PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
# * * * * * $SHELL < /path/to/phpci-cron.sh

CUR_PATH=`pwd`
if ps -ef | grep -v grep | grep "phpci:run-builds"; then
  exit 0
else
  echo "starting phpci cron"
  ${CUR_PATH}/PHPCI/console phpci:run-builds >> ${CUR_PATH}/log/phpci.log
  exit 0
fi