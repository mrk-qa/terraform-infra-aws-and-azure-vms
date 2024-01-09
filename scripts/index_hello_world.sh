#!/bin/bash

apt update -y
apt install -y apache2

systemctl start apache2
systemctl enable apache2

cat <<EOF > /var/www/html/index.html
Hello, World!
EOF