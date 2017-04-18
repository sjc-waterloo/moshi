#sudo adduser frappe sudo

#sudo su frappe


# remove frappe from folder
cd frappe-bench/apps && sudo rm -rf frappe

# drop site & install frappe
cd ../ && bench drop-site 127.0.0.1
bench get-app frappe http://gitlab.moshimori.com/erp/frappe.git

echo -e "\n---- Please Input Your IP Address To Install Erpnext ----"
read -p 'IP Address: ' userip

# create new site
bench new-site $userip
bench --site $userip install-app erpnext

# Setup nginx & supervisor
cd frappe-bench && sudo bench setup production frappe
