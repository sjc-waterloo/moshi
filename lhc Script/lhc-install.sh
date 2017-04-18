echo -e "\n--- Install MySQL-Serer-----"
sudo apt-get install -y mysql-server

echo -e "\n--- Apache2-----"
sudo apt-get install -y apache2

echo -e "\n--- Install PHP5-----"
sudo apt-get install -y php5
sudo apt-get install -y curl php5-curl
sudo apt-get install -y php5-gd
sudo apt-get install -y php5-mysql git

echo -e "\n--- Give Permission-----"
sudo chmod 777 /var/www -R

echo -e "\n--- Install Live Helper Chat-----"
cd /var/www/html

sudo git clone -b johnny http://gitlab.moshimori.com/momochat/momochat.git

# sudo wget https://github.com/remdex/livehelperchat/archive/master.zip
# unzip master.zip
mv momochat live

echo "ServerName localhost" | sudo tee -a /etc/apache2/apache2.conf

sudo /etc/init.d/apache2 restart
sudo chmod 777 /var/www/html/live/lhc_web -R
cd && sudo chmod 777 .cache -R


echo -e "\n--- Open Browser goto: localhost/live/lhc_web-----"
