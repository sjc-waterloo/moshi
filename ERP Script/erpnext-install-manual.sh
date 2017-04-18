# sudo chmod +x erpnext-install.sh
# Execute the script to install ERPNEXT:
# ./erpnext-install
################################################################################

sudo apt-get install -y wget

#--------------------------------------------------
# Run Install Pack
#--------------------------------------------------
echo -e "\n---- Run Install Pack ----"
sudo apt-get update
sudo apt-get install -y curl yum wget vim git build-essential python-setuptools python-dev libffi-dev libssl-dev

sudo wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
sudo pip install --upgrade pip setuptools

sudo pip install 'ansible==2.0.2.0'




