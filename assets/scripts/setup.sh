#!/bin/bash

# Prepare Packages
# @see http://www.arthurtoday.com/2010/09/ubuntu-add-apt-repository.html
echo "Install building packages..."
sudo apt-get -y -qq install \
    automake libtool "g++" \
    expect software-properties-common unzip \
    build-essential flex bison gperf \
    ruby perl git

echo "Install library packages..."
sudo apt-get -y -qq install \
    libsqlite3-dev libfontconfig1-dev libicu-dev libfreetype6 libssl-dev \
    libpng-dev libjpeg-dev python \
    libsqlite3-dev ruby-dev