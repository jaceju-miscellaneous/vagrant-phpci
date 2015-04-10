#!/bin/bash

# Database
mysql -uroot -psecret < /vagrant/assets/phpci.sql

# Code
cd /vagrant
if [ -d "phpci" ]; then mv phpci phpci.bak; fi
composer create-project block8/phpci phpci --keep-vcs --prefer-dist
cd phpci && chmod +x console
./console phpci:install \
    --url="http://phpci.local" \
    --db-host=localhost \
    --db-name=phpci \
    --db-user=phpci \
    --db-pass=secret \
    --admin-name=admin \
    --admin-pass=secret \
    --admin-mail=admin@example.com
cp public/.htaccess.dist public/.htaccess

# Site
cd /etc/apache2/sites-available
sudo rm -f 000-default.conf
cp /vagrant/assets/000-default.conf .
sudo service apache2 restart