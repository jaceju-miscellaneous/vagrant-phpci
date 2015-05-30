#!/bin/bash
## @see http://www.chrisle.me/2013/08/running-headless-selenium-with-chrome/

SHELL=/bin/bash
SCRIPT_PATH=/vagrant/assets/scripts

set -e

if [ -e /.installed ]; then
  echo 'Already installed.'

else
  echo ''
  echo 'INSTALLING'
  echo '----------'

  $SHELL ${SCRIPT_PATH}/swap.sh
  $SHELL ${SCRIPT_PATH}/locale.sh
  $SHELL ${SCRIPT_PATH}/sources.sh
  $SHELL ${SCRIPT_PATH}/setup.sh
  $SHELL ${SCRIPT_PATH}/packages.sh
  $SHELL ${SCRIPT_PATH}/libsass.sh
  $SHELL ${SCRIPT_PATH}/mailcatcher.sh
  $SHELL ${SCRIPT_PATH}/composer.sh
  $SHELL ${SCRIPT_PATH}/phpci.sh
  $SHELL ${SCRIPT_PATH}/apache2.sh

  # So that running `vagrant provision` doesn't redownload everything
  sudo touch /.installed
fi