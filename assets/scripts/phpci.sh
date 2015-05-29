#!/bin/bash
echo "Install PHPCI..."

# Code Backup
cd /vagrant
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
