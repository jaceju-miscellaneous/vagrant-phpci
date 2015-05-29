#!/bin/bash

# Swap
sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# Init
# @see http://www.arthurtoday.com/2010/09/ubuntu-add-apt-repository.html
sudo apt-get -qq update
sudo apt-get -y -qq install automake libtool "g++" \
    expect software-properties-common unzip \
    build-essential flex bison gperf ruby perl \
    libsqlite3-dev libfontconfig1-dev libicu-dev libfreetype6 libssl-dev \
    libpng-dev libjpeg-dev python

# Add Keys & source list
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
## Update
sudo apt-get -qq update

# Locale
sudo locale-gen en_US.UTF-8
REP1='LANGUAGE="en_US.UTF-8"\nLC_ALL="en_US.UTF-8"\nLC_CTYPE="en_US.UTF-8"\nLANG="en_US.UTF-8"'
sudo echo -e $REP1|cat /etc/environment - > /tmp/out && sudo mv /tmp/out /etc/environment

# PHP
sudo apt-get -y -qq install php5 php5-curl php5-ldap php5-mcrypt php5-gearman php5-memcached php5-gd php5-imagick php5-geoip php5-mysql php5-sqlite php5-xdebug

# PhantomJS
sudo apt-get -y -qq install phantomjs

# MySQL (after PHP)
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password secret'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password secret'
sudo apt-get -y -qq install mysql-server

# Git
sudo apt-get -y -qq install git

# Node.js
curl -sL https://deb.nodesource.com/setup_0.12 | sudo bash -
sudo apt-get -y -qq install nodejs

# Selenium & Xvfb
## @see http://mike.ucoz.com/publ/programming/ubuntu/selenium_ubuntu_amazon_ec2_headless/8-1-0-4
## Install headless java & fonts & xvfb & xserver (important)
sudo apt-get -y -qq install openjdk-7-jre-headless \
                            xfonts-100dpi xfonts-75dpi \
                            xfonts-scalable xfonts-cyrillic \
                            xvfb xserver-xorg-core

# Firefox
## install dbus-x11 to fix "//bin/dbus-launch terminated abnormally without any error message"
sudo apt-get -y -qq install dbus-x11 firefox

# Google Chrome
# @see http://www.howopensource.com/2011/10/install-google-chrome-in-ubuntu-11-10-11-04-10-10-10-04/
sudo apt-get -y -qq install google-chrome-stable

# OperaDriver
wget -N https://github.com/operasoftware/operachromiumdriver/releases/download/v0.2.2/operadriver_linux64.zip
unzip operadriver_linux64.zip
rm -f operadriver_linux64.zip
chmod +x operadriver
sudo mv operadriver /usr/local/share/
sudo ln -s /usr/local/share/operadriver /usr/bin/operadriver

# ChromeDriver
wget -N http://chromedriver.storage.googleapis.com/2.10/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
rm -f chromedriver_linux64.zip
chmod +x chromedriver
sudo mv chromedriver /usr/local/share/
sudo ln -s /usr/local/share/chromedriver /usr/bin/chromedriver

# Libsass
git clone https://github.com/sass/libsass.git
git clone https://github.com/sass/sassc.git libsass/sassc
cd libsass
autoreconf --force --install
./configure \
  --disable-tests \
  --enable-shared \
  --prefix=/usr
cd ..
sudo make -C libsass -j5 install

# MailCatcher
sudo apt-get -y -qq install libsqlite3-dev ruby-dev
sudo gem install mailcatcher -q
sudo cp /vagrant/assets/mailcatcher.conf /etc/init/

# Apache (after PHP)
sudo a2enmod rewrite

# Composer (after PHP)
sudo cp /vagrant/assets/composer.phar /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer
sudo composer self-update

# Database
mysql -uroot -psecret < /vagrant/assets/phpci.sql

# Code
cd /vagrant

# Backup
for i in `seq 1 1 10`;
do
    if [ -d "phpci.$i" ];
    then
        j=$(($i+1))
        mv "phpci.$i" "phpci.$j"
        break;
    fi
done

if [ -d "phpci" ];
then
    mv phpci phpci.1
fi

# PHPCI
tar xzf assets/phpci.tar.gz phpci
cd phpci
git pull
./console phpci:install \
    --url="http://phpci.local" \
    --db-host=localhost \
    --db-name=phpci \
    --db-user=phpci \
    --db-pass=secret \
    --admin-name=admin \
    --admin-pass=secret \
    --admin-mail=admin@example.com
sed -e "s/http:\/\/phpci\.local/\/\/phpci.local/" PHPCI/config.yml > /tmp/out && mv /tmp/out PHPCI/config.yml
mv public/.htaccess.dist public/.htaccess

# Site
cd /etc/apache2
REP2='ServerName phpci.local\nListen 80'
sudo sed -e "s/Listen 80/$(echo $REP2)/" /etc/apache2/ports.conf > /tmp/out && sudo mv /tmp/out /etc/apache2/ports.conf

cd /etc/apache2/sites-available
sudo rm -f *.conf
cp /vagrant/assets/*.conf .

# SSL Key
sudo mkdir /etc/apache2/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -subj "/C=TW/ST=Taiwan/L=Taipei/O=Home/OU=Web/CN=phpci.local" \
    -keyout /etc/apache2/ssl/apache.key \
    -out /etc/apache2/ssl/apache.crt
sudo a2enmod ssl
sudo a2ensite default-ssl
sudo service apache2 restart
