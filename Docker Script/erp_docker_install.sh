sudo git clone http://gitlab.moshimori.com/steven/dockererp.git
cd dockererp && sudo docker build -t "mmerp" .

docker create -v /home/frappe/frappe-bench/sites/127.0.0.1/ -v /var/lib/mysql --name erpdata mmerp

# docker run -d -p 80:80 -p 8000:8000 --name erpnext --volumes-from erpdata mmerp

sudo docker run -d -p 80:80 -p 8000:8000 --name erpnext1 -v $(pwd):/home/stevencao --volumes-from erpdata mmerp

