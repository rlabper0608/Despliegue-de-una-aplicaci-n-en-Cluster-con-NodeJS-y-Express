#!/bin/bash

set -xeu
apt-get update -y

sudo apt install -y nodejs npm
mkdir -p practica-cluster

cd /home/vagrant/practica-cluster
npm init -y
npm install express 
npm install -g loadtest
npm install -g pm2

cp /vagrant/app.js /home/vagrant/practica-cluster/app.js

node app.js

pm2 start app.js -i 0

