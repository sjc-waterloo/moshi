# sudo chmod +x erpnext-devinstall.sh
# Execute the script to install ERPNEXT:
# ./erpnext-devinstall
################################################################################

sudo apt-get install -y wget

#--------------------------------------------------
# Run Install Pack
#--------------------------------------------------
echo -e "\n---- Run Install Pack ----"
sudo wget 52.193.43.249/static/rec/X1/install.py
sudo python install.py --develop

#--------------------------------------------------
# Install erpnext
#--------------------------------------------------

git clone https://github.com/frappe/bench bench-repo
sudo pip install -e bench-repo

bench get-app erpnext http://gitlab.moshimori.com/steven/ERPNextmoshi.git


echo -e "\n---- Please Input Your IP Address To Install Erpnext"
read -p 'IP Address: ' userip


bench new-site $userip
bench --site $userip install-app erpnext

cd frappe-bench
bench start

