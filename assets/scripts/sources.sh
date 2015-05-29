#!/bin/bash

# Add Keys & source list
echo "Update sources..."
## PHP
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C
sudo sh -c 'echo "deb http://ppa.launchpad.net/ondrej/php5-5.6/ubuntu trusty main" > /etc/apt/sources.list.d/ondrej-php5-5_6-trusty.list'
## PhantomJS
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 9CE6C37ED6243D66
sudo sh -c 'echo "deb http://ppa.launchpad.net/tanguy-patte/phantomjs/ubuntu trusty main" > /etc/apt/sources.list.d/phantomjs.list'
sudo sh -c 'echo "deb-src http://ppa.launchpad.net/tanguy-patte/phantomjs/ubuntu trusty main" >> /etc/apt/sources.list.d/phantomjs.list'
## Firefox
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A6DCF7707EBC211F
sudo sh -c 'echo "deb http://ppa.launchpad.net/ubuntu-mozilla-security/ppa/ubuntu trusty main" >> /etc/apt/sources.list.d/mozilla-security.list'
sudo sh -c 'echo "deb-src http://ppa.launchpad.net/ubuntu-mozilla-security/ppa/ubuntu trusty main" >> /etc/apt/sources.list.d/mozilla-security.list'
## Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
