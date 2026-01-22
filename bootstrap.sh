#!/bin/bash

set -xeu
apt-get update -y

sudo apt install -y nodejs npm
mkdir practica-cluster

cd /home/vagrant/practica-cluster
npm init
npm install express

cp /vagrant/app.js /home/vagrant/practica-cluster/app.js

node app.js