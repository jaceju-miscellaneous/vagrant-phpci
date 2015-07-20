#!/bin/bash
echo "Install PHPCI..."

# PHPCI
cd /var/www
sudo tar xzf /vagrant/assets/phpci/phpci.tar.gz
sudo chown -R www-data.www-data phpci
cd /var/www/phpci
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
