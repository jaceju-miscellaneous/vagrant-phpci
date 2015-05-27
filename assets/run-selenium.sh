#!/bin/bash

BASE_PATH="/Users/jaceju/Vagrant/vagrant-phpci/assets"

java -jar ${BASE_PATH}/selenium-server-standalone-2.45.0.jar \
	-firefoxProfileTemplate ${BASE_PATH}/firefox-profile \
	-log ${BASE_PATH}/selenium.log \
	-hub http://127.0.0.1:4444/wd/hub
