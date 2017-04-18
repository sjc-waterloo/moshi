sudo apt-get install -y curl wget git
curl -ssl https://get.docker.com | sh
sudo usermod -aG docker $USER
sudo reboot




sudo docker run -d -p 80:80 -p 8000:8000 --name erpnext1 -v $(pwd):/home/stevencao --volumes-from erpdata mmerp
