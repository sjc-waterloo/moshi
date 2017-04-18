#!/bin/bash
apt-get update && apt-get install -y wget ca-certificates sudo cron supervisor npm
/usr/bin/supervisord

wget http://gitlab.moshimori.com/ERP/bench/raw/master/playbooks/install.py
sudo python install.py --production
rm /home/frappe/*.deb

exit 0
