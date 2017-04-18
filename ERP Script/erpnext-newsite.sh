# sudo chmod +x erpnext-install.sh
# Execute the script to install ERPNEXT:
# ./erpnext-newsite.sh
################################################################################

sitename = $1.moshimori.com
userid = $2
password = $3
userip = 52.163.118.245


curl -X PATCH https://api.godaddy.com/v1/domains/moshimori.com/records -H 'Authorization: sso-key dKiBRpgzwFYL_UNSSBdMXvi7qGHDeDpRGcB:WK15SwJjACVKoCFsoxauzY' -H 'Content-Type:application/json' --data '[{"type": "A", "name": $userid, "data":$userip, "ttl":3600}]'

cd frappe-bench
bench new-site $sitename
bench --site $sitename install-app erpnext

sudo bench setup nginx

bench set-nginx-port $sitename 80
echo "$userip $sitename" | sudo tee -a /etc/hosts

sudo bench config dns_multitenant on

sudo service nginx reload


