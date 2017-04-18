echo -e "\n---- 安裝部署環境 ----"

sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install apache2 mysql-server php5-gd php5-mysql wget vim -y
sudo mysql_install_db
sudo mysql_secure_installation
sudo apt-get install php5 libapache2-mod-php5 php5-mcrypt -y
sudo php5enmod mcrypt
sudo apt-get update -y

sudo service apache2 restartsu  

echo -e "\n---- 安裝PHPmyadmin ----"

sudo apt-get install phpmyadmin -y
sudo vim /etc/phpmyadmin/config-db.php
sudo sed -i "s/dbuser='phpmyadmin';/dbuser='root';/g" /etc/phpmyadmin/config-db.php
sudo sed -i "s/dbpass=.*/dbpass='Moshimoribplus123';/g" /etc/phpmyadmin/config-db.php
sudo sed -i "s/dbname='phpmyadmin';/dbname='';/g" /etc/phpmyadmin/config-db.php
cd /var/www/html &&  sudo ln -s /usr/share/phpmyadmin

echo -e "\n---- 啟用友善聯結 ----"
sudo a2enmod rewrite
sudo service apache2 restart
# sudo nano /etc/apache2/sites-enabled/000-default.conf

wget http://gitlab.moshimori.com/steven/moshimori/raw/master/apache2_conf_addon.txt

sudo sed -i '/DocumentRoot \/var\/www\/html/r apache2_conf_addon.txt' /etc/apache2/sites-enabled/000-default.conf

sudo service apache2 restart
sudo touch /var/www/html/.htaccess

echo "\t RewriteEngine on" >> /var/www/html/.htaccess

echo -e "\n---- 給予權限 ----"
sudo chmod 644 /var/www/html/.htaccess
sudo chmod 777 -R /var/www/html



#Permission issues:
#sudo chown -R www-data:www-data /var/www/html

#-----

#放入檔案 http://gitlab.moshimori.com/ec/mm-ec/tree/master

