#!/bin/bash

set -xeu
apt-get update -y

sudo apt install -y nodejs npm
mkdir -p practica-cluster

cd /home/vagrant/practica-cluster
npm init -y
npm install express 
npm install -g loadtest

cp /vagrant/app.js /home/vagrant/practica-cluster/app.js

node app.js
