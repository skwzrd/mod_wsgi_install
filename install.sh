#!/usr/bin/env bash

# configs
host_domain="xyz.com"
host="xyz"
email="xyz@xyz.com"
# end configs

apt update
apt install apache2 apache2-dev python3-dev python3-distutils

cp ./host_domain.conf "/etc/apache2/sites-available/$host_domain.conf"

sed -i -e "s/<host_domain>/$host_domain/g" "/etc/apache2/sites-available/$host_domain.conf"
sed -i -e "s/<email>/$email/g" "/etc/apache2/sites-available/$host_domain.conf"

a2dissite 000-default.conf
a2ensite "$host_domain.conf"
a2enmod wsgi ssl rewrite

sudo apt install ufw
sudo ufw enable
sudo ufw allow 'Apache Full'

# # For serving static html pages instead of dynamic python pages
# rm /var/www/html/index.html
# mkdir -p "/var/www/html/$host_domain"
# chown -R $USER:$USER /"var/www/html/$host_domain"
# chmod -R 755 /var/www
# touch "/var/www/html/$host_domain/index.html"

wget -qO- https://github.com/GrahamDumpleton/mod_wsgi/archive/refs/tags/4.9.3.tar.gz | tar xvz -C ~/Downloads
cd ~/Downloads/mod_wsgi-4.9.3
./configure --with-python=/usr/bin/python3
make
make install
cp ./wsgi.load /etc/apache2/mods-available/wsgi.load

mkdir -p "/usr/local/www/wsgi-scripts/$host"

cp ./main.py "/usr/local/www/wsgi-scripts/$host_domain/main.py"

snap install core; snap refresh core
apt-get remove certbot
snap install --classic certbot
ln -s /snap/bin/certbot /usr/bin/certbot
certbot certonly --apache
certbot renew --dry-run

apache2ctl configtest
systemctl restart apache2
