 # sudo chmod +x erpnext-install.sh
# Execute the script to install ERPNEXT:
# ./erpnext-install
################################################################################

sudo apt-get install -y wget

#--------------------------------------------------
# Run Install Pack
#--------------------------------------------------
echo -e "\n---- Run Install Pack ----"
sudo wget 52.193.43.249/static/rec/X1/install.py
sudo python install.py --production

#--------------------------------------------------
# Install erpnext
#--------------------------------------------------

git clone https://github.com/frappe/bench bench-repo
sudo pip install -e bench-repo
bench init frappe-bench && cd frappe-bench

cd frappe-bench
bench get-app erpnext http://gitlab.moshimori.com/ERP/mmerp.git


echo -e "\n---- Please Input Your IP Address To Install Erpnext"
read -p 'IP Address: ' userip

cd frappe-bench
bench new-site $userip
bench --site $userip install-app erpnext

sudo bench setup production $USER


