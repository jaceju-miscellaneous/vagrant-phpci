## Install headless java
sudo apt-get -y -qq install openjdk-7-jre-headless

## Fonts
sudo apt-get -y -qq install xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic

## Headless X11 magic is here
sudo apt-get -y -qq install xvfb

## We still demand X11 core
sudo apt-get -y -qq install xserver-xorg-core

## Firefox installation
sudo apt-get -y -qq install firefox

## Run Xvfb with selenium server
Xvfb :0 -screen 0 1024x768x24 2>&1 >/dev/null &
export DISPLAY=:0
nohup xvfb-run java -jar /vagrant/assets/selenium-server-standalone-2.45.0.jar > selenium.log &
