# Author stevenjcao
# sudo chmod +x lhc-new.sh
# Execute the script to install a new live helper chat:
# ./lhc-new.sh
################################################################################


# Get Current User Name
echo -e "\n ---- Please Enter Your User Name -----"
read -p 'User Name: ' username
echo $username

#################################################################
# echo -e "\n ---- Please Enter The Database You Want To Import"#
# read -p 'MySQLdb Name: ' mysqldbname                          #
# echo $mysqldbname                                             #
# Export mysql database                                         #
# sudo su root                                                  #
# mysqldump -u root -p $mysqldbname > $mysqldbname.sql          #
#################################################################

# Install Live Helper Chat
echo -e "\n--- Install Live Helper Chat -----"
mv /home/stevencao/live2.zip /var/www/html/
cd /var/www/html
unzip live2.zip
# sudo apt-get install -y git
# git clone http://gitlab.moshimori.com/momochat/momochat.git
mv live2 $username

# Get MySQL root passwod
echo -e "\n--- Please Enter Root User MySQL Password -----"
read rootpasswd

# Create mysql Database
echo -e "\n--- Create Mysql Database -----"
mysql -uroot -p${rootpasswd} -e "CREATE DATABASE $username;"
mysql -uroot -p${rootpasswd} -e "GRANT ALL ON $username.* TO 'root'@'localhost' WITH GRANT OPTION;"
mysql -uroot -p${rootpasswd} -e "FLUSH PRIVILEGES;"

# Import from existing Database
echo -e "\n--- Import From Existing Database -----"
cd
sudo cp /home/stevencao/live2.sql /var/lib/mysql
cd /var/lib/mysql && mysql -u root -p${rootpasswd} $username < live2.sql
cd
cd /var/www/html/$username/lhc_web/settings

# Change config file to link site with imported database
echo -e "\n--- Link Database -----"
sed -i -- 's/12345678/'"$rootpasswd"'/g' settings.ini.php
sed -i -- 's/live2/'"$username"'/g' settings.ini.php

echo -e "\n--- New Site Has Been Created -----"
echo -e "\n--- Proceed to http://127.0.0.1/live_test/lhc_web -----"











