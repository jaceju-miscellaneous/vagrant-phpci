#!/bin/bash

# Composer (after PHP)
echo "Install Composer..."
sudo cp /vagrant/assets/composer.phar /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer
sudo composer self-update