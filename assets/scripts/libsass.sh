#!/bin/bash

# Libsass
echo "Install libsass..."
git clone https://github.com/sass/libsass.git
git clone https://github.com/sass/sassc.git libsass/sassc
cd libsass
autoreconf --force --install
./configure \
  --disable-tests \
  --enable-shared \
  --prefix=/usr
cd ..
sudo make -C libsass -j8 install