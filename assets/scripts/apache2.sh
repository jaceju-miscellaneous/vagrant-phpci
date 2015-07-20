#!/bin/bash

echo "Setup Apache2..."

# Site
cd /etc/apache2
REP2='ServerName phpci.local\nListen 80'
sudo sed -e "s/Listen 80/$(echo $REP2)/" /etc/apache2/ports.conf > /tmp/out && sudo mv /tmp/out /etc/apache2/ports.conf
sudo a2enmod rewrite

cd /etc/apache2/sites-available
sudo rm -f *.conf
cp /vagrant/assets/apache2/*.conf .

# SSL Key
sudo mkdir /etc/apache2/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -subj "/C=TW/ST=Taiwan/L=Taipei/O=Home/OU=Web/CN=phpci.local" \
    -keyout /etc/apache2/ssl/apache.key \
    -out /etc/apache2/ssl/apache.crt
sudo a2enmod ssl
sudo a2ensite default-ssl
sudo service apache2 restart
