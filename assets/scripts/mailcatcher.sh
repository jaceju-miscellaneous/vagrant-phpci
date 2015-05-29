#!/bin/bash

# MailCatcher
echo "Install MailCatcher..."
sudo gem install mailcatcher -q
sudo cp /vagrant/assets/mailcatcher.conf /etc/init/
