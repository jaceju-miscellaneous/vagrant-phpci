#!/bin/bash

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
sudo rm -f *.conf
cp /vagrant/assets/*.conf .
sudo service apache2 restart