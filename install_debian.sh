#!/bin/bash

sudo adduser macro-dash #pw macro-dash
#sudo usermod -aG sudo macro-dash

sudo apt update
sudo apt -y install nginx

sudo apt update

sudo apt -y install r-base-dev

sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
sudo /sbin/mkswap /var/swap.1
sudo /sbin/swapon /var/swap.1
sudo sh -c 'echo "/var/swap.1 swap swap defaults 0 0 " >> /etc/fstab'

sudo apt -y install libcurl4-gnutls-dev libxml2-dev libssl-dev libgit2-dev libfontconfig1-dev libharfbuzz-dev libfribidi-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev

#cd /home/macro-dash

#sudo apt -y install git
#git pull https://github.com/josephcbradley/macro-dashboard.git 

Rscript setup.R

sudo apt -y install gdebi-core
wget https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.15.953-amd64.deb
sudo gdebi -n shiny-server-1.5.15.953-amd64.deb

sudo groupadd shiny-apps
sudo usermod -aG shiny-apps macro-dash
sudo usermod -aG shiny-apps shiny
cd /srv/shiny-server
sudo chown -R macro-dash:shiny-apps .
sudo chmod g+w .
sudo chmod g+s .

sudo mv /etc/nginx/sites-enabled/default /etc/nginx/sites-enabled/default.old
sudo cp ~/macro-dash/macro-dashboard/config/default /etc/nginx/sites-enabled/default
sudo service nginx restart

