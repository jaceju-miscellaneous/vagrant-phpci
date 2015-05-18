## Run Xvfb with selenium server
Xvfb :0 -screen 0 1024x768x24 2>&1 >/dev/null &
export DISPLAY=:0
nohup xvfb-run java -jar /vagrant/assets/selenium-server-standalone-2.45.0.jar > selenium.log &
