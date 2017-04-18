#!/bin/sh

echo "Please User super(root) user to exec this script, or press Ctrl+C to cancel and re-do this script"
echo -n "Please input the account name: "
read ACCOUNT
PASSWORD=$(echo -n $ACCOUNT | md5sum | awk '{print $1}' | cut -c 3-8 | md5sum | awk '{print $1}')

if [ ! -d mysqlScript ] ; then
	mkdir mysqlScript
fi

echo -n "" > ./mysqlScript/$ACCOUNT.sql
echo "use mysql;" >> ./mysqlScript/$ACCOUNT.sql
echo "create database $ACCOUNT;" >> ./mysqlScript/$ACCOUNT.sql
echo "INSERT INTO user(host,user,password) VALUES('%','$ACCOUNT',password('$PASSWORD'));" >> ./mysqlScript/$ACCOUNT.sql
echo "GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER ON *.* TO '$ACCOUNT'@localhost IDENTIFIED BY '$PASSWORD' WITH GRANT OPTION;" >> ./mysqlScript/$ACCOUNT.sql
echo "grant all privileges on $ACCOUNT.* to $ACCOUNT@localhost;" >> ./mysqlScript/$ACCOUNT.sql
echo "FLUSH PRIVILEGES;" >> ./mysqlScript/$ACCOUNT.sql

if [ ! -d www ] ; then
	mkdir www
fi

echo -n "Please input the virtual host name: "
read vHOST
echo $vHOST

if [ ! -d /var/www/html/$vHOST ] ; then
	mkdir /var/www/html/$vHOST;
fi

#git clone -b develop  http://gitlab.moshimori.com/ec/mmecjms.git


git clone -b develop http://gitlab.moshimori.com/ec/mmecleo.git
# unzip  mm0317.zip -d /var/www/html/$vHOST

wget http://gitlab.moshimori.com/ec/mmecleo/raw/develop/mmleo2017_03_20.sql
# --- ---- --- ----如果 版本更新，需改 （数据库 .sql 路径）

mv *.sql import.sql

mv mmecleo mm

#sudo sed -n '1,2p' mm/config/settings.inc.php > settings.inc-header.txt
#sudo sed -n '4,16p' mm/config/settings.inc.php > settings.inc-footer.txt

sudo sed -n '1,1p' /etc/apache2/sites-enabled/000-default.conf > site-available-header.txt
sudo sed -n '2,31p' /etc/apache2/sites-enabled/000-default.conf > site-available-footer.txt

mv mm /var/www/html/$vHOST

#mv /var/www/html/$vHOST/prestashop /var/www/html/$vHOST/mall

siteCONFIG=/etc/apache2/sites-available/$vHOST

echo -n "" > $siteCONFIG

cat ./site-available-header.txt >> $siteCONFIG
echo "\t ServerName $vHOST" >> $siteCONFIG
#:echo "\t ServerAlias $vHOST" >> $siteCONFIG
cat ./site-available-footer.txt >> $siteCONFIG

sed -i 's/ServerAdmin webmaster@localhost/ServerAdmin '"$vHOST"'/g' $siteCONFIG
sed -i 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/html\/'"$vHOST"'/g' $siteCONFIG
sed -i 's/Directory \/var\/www\/html/Directory \/var\/www\/html\/'"$vHOST"'/g' $siteCONFIG



mv /etc/apache2/sites-available/$vHOST /etc/apache2/sites-available/$vHOST.conf

if [ ! -f $siteCONFIG ]; then
	ln -s $siteCONFIG /etc/apache2/sites-enabled/$vHOST
fi

sudo service apache2 reload
sudo service apache2 restart


#/etc/init.d/apache2 restart

echo "Please go to http://$vHOST/mall/install or http://$(hostname -I | awk '{print $1}')/$vHOST/ec/install to setup the mall"
echo "Please go to http://$vHOST/cms or http://$(hostname -I | awk '{print $1}')/$vHOST/cms to setup the cms"
echo "MySQL Username: $ACCOUNT"
echo "MySQL Password: $PASSWORD"

mysql -u root -p < ./mysqlScript/$ACCOUNT.sql

#cp mm0317.sql import.sql

sed -i 's/52.187.31.73/54.70.0.49/g' import.sql
sed -i 's/52.33.190.253/54.70.0.49/g' import.sql
sed -i "s/mm/$vHOST\/ec/g" import.sql

mysql -u root -h localhost -p $ACCOUNT < import.sql

psSetting=/var/www/html/$vHOST/mm/config/settings.inc.php:

sudo sed -i "s/'mm'/'"$ACCOUNT"'/g" /var/www/html/$vHOST/mm/config/settings.inc.php

#echo -n "" > $psSetting
#cat ./settings.inc-header.txt >> $psSetting
#echo "define('_DB_NAME_', '$ACCOUNT');" >> $psSetting
#cat ./settings.inc-footer.txt >> $psSetting

mv /var/www/html/$vHOST/mm /var/www/html/$vHOST/ec

sed -i 's/\/mm/\/'"$vHOST"'\/ec/g' /var/www/html/$vHOST/ec/.htaccess
sudo chown -R www-data:www-data /var/www/html

#sudo rm -rf site-available-footer.txt site-available-header.txt import.sql
