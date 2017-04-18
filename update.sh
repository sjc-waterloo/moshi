git config --global user.email "steven@moshimori.com"
git config --global user.name "steven"

cd /home/frappe/frappe-bench/apps/erpnext
git remote remove upstream
git remote add upstream http://gitlab.moshimori.com/ERP/erp.git
git fetch upstream
git stash

cd /home/frappe/frappe-bench/apps/frappe
git remote remove upstream
git remote add upstream http://gitlab.moshimori.com/ERP/frappe.git
git fetch upstream
git stash

cd /home/frappe/frappe-bench
sudo bench switch-to-branch official --upgrade

sudo service nginx restart
sudo supervisorctl reload


