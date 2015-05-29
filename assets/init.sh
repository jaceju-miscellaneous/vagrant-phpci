#!/bin/bash

SHELL=/bin/bash
SCRIPT_PATH=/vagrant/assets/scripts

$SHELL ${SCRIPT_PATH}/swap.sh
$SHELL ${SCRIPT_PATH}/parallel.sh

echo "==============================="
parallel $SHELL {} ::: \
"${SCRIPT_PATH}/setup.sh
${SCRIPT_PATH}/sources.sh
${SCRIPT_PATH}/nodejs.sh
${SCRIPT_PATH}/locale.sh
${SCRIPT_PATH}/packages.sh
${SCRIPT_PATH}/operadriver.sh
${SCRIPT_PATH}/chromedriver.sh
${SCRIPT_PATH}/libsass.sh
${SCRIPT_PATH}/mailcatcher.sh
${SCRIPT_PATH}/composer.sh"
echo "==============================="

$SHELL ${SCRIPT_PATH}/phpci.sh
$SHELL ${SCRIPT_PATH}/apache2.sh