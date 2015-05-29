#!/bin/bash

# OperaDriver
echo "Install OperaDriver..."
wget -N https://github.com/operasoftware/operachromiumdriver/releases/download/v0.2.2/operadriver_linux64.zip
unzip operadriver_linux64.zip
rm -f operadriver_linux64.zip
chmod +x operadriver
sudo mv operadriver /usr/local/share/
sudo ln -s /usr/local/share/operadriver /usr/bin/operadriver
