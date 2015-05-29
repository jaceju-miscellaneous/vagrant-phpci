#!/bin/bash

# ChromeDriver
echo "Install ChromeDriver..."
wget -N http://chromedriver.storage.googleapis.com/2.10/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
rm -f chromedriver_linux64.zip
chmod +x chromedriver
sudo mv chromedriver /usr/local/share/
sudo ln -s /usr/local/share/chromedriver /usr/bin/chromedriver
