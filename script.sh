#!/bin/bash
apt-get update
apt-get install -y postgresql
apt-get install -y ufw
sudo ufw allow 5432/tcp
sudo ufw reload
sudo -u postgres psql
ALTER USER postgres WITH PASSWORD 'Password123';
