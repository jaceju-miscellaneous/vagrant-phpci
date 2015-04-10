#!/bin/bash

# Locale
sudo locale-gen en_US.UTF-8
REP1='LANGUAGE="en_US.UTF-8"\nLC_ALL="en_US.UTF-8"\nLC_CTYPE="en_US.UTF-8"\nLANG="en_US.UTF-8"'
sudo echo -e $REP1|cat /etc/environment - > /tmp/out && sudo mv /tmp/out /etc/environment

# PHP
sudo echo "deb http://ppa.launchpad.net/ondrej/php5-5.6/ubuntu trusty main" > /etc/apt/sources.list.d/ondrej-php5-5_6-trusty.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C
sudo apt-get update
sudo apt-get -y install php5 php5-ldap php5-mcrypt php5-gearman php5-memcached php5-gd php5-imagick php5-geoip php5-mysql php5-sqlite php5-xdebug

# MySQL (after PHP)
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password secret'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password secret'
sudo apt-get -y install mysql-server

# Git
sudo apt-get -y install git

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
./console phpci:install \
    --url="//phpci.local" \
    --db-host=localhost \
    --db-name=phpci \
    --db-user=phpci \
    --db-pass=secret \
    --admin-name=admin \
    --admin-pass=secret \
    --admin-mail=admin@example.com
mv .htaccess.dist .htaccess


# Site
cd /etc/apache2
REP2='ServerName phpci.local\nListen 80'
sudo sed -e "s/Listen 80$/$(echo $REP2)/" /etc/apache2/ports.conf > /tmp/out && sudo mv /tmp/out /etc/apache2/ports.conf

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