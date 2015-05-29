#!/bin/bash

# Locale
echo "Set locale..."
sudo locale-gen en_US.UTF-8
REP1='LANGUAGE="en_US.UTF-8"\nLC_ALL="en_US.UTF-8"\nLC_CTYPE="en_US.UTF-8"\nLANG="en_US.UTF-8"'
sudo echo -e $REP1|cat /etc/environment - > /tmp/out && sudo mv /tmp/out /etc/environment
