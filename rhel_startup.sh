#!/bin/bash

echo -e "startup file"


apt update
apt install apache2  -y 
apt install python3 -y 

# Enable mod_rewrite for Apache
sudo a2enmod rewrite

# Create a custom index.html that displays the hostname
HOSTNAME=$(hostname)
echo "<html><body><h1>Hostname: $HOSTNAME</h1></body></html>" | sudo tee /var/www/html/index.html

# Restart Apache to apply changes
sudo systemctl restart apache2


mkdir -p  /opt/app
cd /opt/app



############
# add code to put metadata and get value dynamically part
gcloud storage cp gs://ask-proj-35-main/load_generator.py .
gcloud storage cp gs://ask-proj-35-main/py_load.service .

echo -e "creating py related service"

sudo cp py_load.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable py_load.service


# echo -e "starting load"
# python3 ./load_generator.py
# echo -e "load completed"


