#!/bin/bash

# SSL Key
sudo a2enmod ssl
sudo mkdir /etc/apache2/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -subj "/C=TW/ST=Taiwan/L=Taipei/O=Home/OU=Web/CN=phpci.local" \
    -keyout /etc/apache2/ssl/apache.key \
    -out /etc/apache2/ssl/apache.crt
sudo service apache2 restart