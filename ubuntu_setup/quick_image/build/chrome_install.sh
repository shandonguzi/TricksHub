#!/bin/bash

export https_proxy=172.19.0.1:7890

# chrome & chromedriver
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O ./chrome.deb

DRIVER=$(curl -sS https://chromedriver.storage.googleapis.com/LATEST_RELEASE)

wget https://chromedriver.storage.googleapis.com/"$DRIVER"/chromedriver_linux64.zip -O ./chromedriver.zip

unzip ./chromedriver.zip -d /bin
chmod +x /bin/chromedriver
apt install ./chrome.deb -y
