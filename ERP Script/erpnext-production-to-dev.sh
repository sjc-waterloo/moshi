cd frappe-bench
sudo rm config/supervisor.conf
sudo rm config/nginx.conf
sudo service nginx stop
sudo service supervisor stop
bench start

