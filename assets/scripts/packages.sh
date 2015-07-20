#!/bin/bash

## @see http://mike.ucoz.com/publ/programming/ubuntu/selenium_ubuntu_amazon_ec2_headless/8-1-0-4
## Install headless java & fonts & xvfb & xserver (important)
## install dbus-x11 to fix "//bin/dbus-launch terminated abnormally without any error message"
## Google Chrome
## @see http://www.howopensource.com/2011/10/install-google-chrome-in-ubuntu-11-10-11-04-10-10-10-04/

echo "Install PHP and NodeJS..."
sudo apt-get -y -qq install \
    php5 php5-curl php5-ldap \
    php5-mcrypt php5-gearman php5-memcached \
    php5-gd php5-imagick php5-geoip php5-mysql \
    php5-sqlite php5-xdebug nodejs

# MySQL (after PHP)
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password secret'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password secret'
sudo apt-get -y -qq install mysql-server

# Database
echo "Install database..."
mysql -uroot -psecret < /vagrant/assets/phpci/phpci.sql
