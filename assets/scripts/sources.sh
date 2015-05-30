#!/bin/bash

echo "Update sources..."

## PHP
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C
sudo sh -c 'echo "deb http://ppa.launchpad.net/ondrej/php5-5.6/ubuntu trusty main" > /etc/apt/sources.list.d/ondrej-php5-5_6-trusty.list'

## Node Source & Update
curl -sL https://deb.nodesource.com/setup_0.12 | sudo bash -
