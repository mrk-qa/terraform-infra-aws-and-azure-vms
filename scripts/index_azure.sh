#!/bin/bash

apt update -y
apt install -y apache2

PROVIDER_NAME="Azure"

systemctl start apache2
systemctl enable apache2

LOCATION=$(curl -s -H Metadata:true "http://169.254.169.254/metadata/instance/compute/location?api-version=2021-01-01&format=text")
PUBLIC_IP=$(curl -s -H Metadata:true "http://169.254.169.254/metadata/instance/network/interface/0/ipv4/ipAddress/0/publicIpAddress?api-version=2021-02-01&format=text")
VM_SIZE=$(curl -s -H Metadata:true "http://169.254.169.254/metadata/instance/compute/vmSize?api-version=2021-01-01&format=text")

HTML_DIR="/var/www/html"

mkdir -p "$HTML_DIR"

HTML_FILE="$HTML_DIR/index.html"

sudo sed -i 's@DocumentRoot /var/www/html@DocumentRoot /var/www/html\n\t<Directory /var/www/html>\n\t\tOptions Indexes FollowSymLinks\n\t\tAllowOverride None\n\t\tRequire all granted\n\t</Directory>@' /etc/apache2/sites-available/000-default.conf

systemctl restart apache2

echo "Configuração concluída. O Apache2 está agora configurado para usar /var/www/html como DocumentRoot."

cat <<EOF > "$HTML_FILE"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        @import url('https://fonts.googleapis.com/css?family=Open+Sans&display=swap');
        html {
            position: relative;
            overflow-x: hidden !important;
        }
        * {
            box-sizing: border-box;
        }
        body {
            font-family: 'Open Sans', sans-serif;
            color: #324e63;
        }
        .wrapper {
            width: 100%;
            height: auto;
            min-height: 90vh;
            padding: 50px 20px;
            padding-top: 100px;
            display: flex;
        }
        .instance-card {
            width: 100%;
            min-height: 380px;
            margin: auto;
            box-shadow: 12px 12px 2px 1px rgba(13, 28, 39, 0.4);
            background: #fff;
            border-radius: 15px;
            border-width: 1px;
            max-width: 500px;
            position: relative;
            border: thin groove #9c83ff;
        }
        .instance-card__cnt {
            margin-top: 35px;
            text-align: center;
            padding: 0 20px;
            padding-bottom: 40px;
            transition: all .3s;
        }
        .instance-card__name {
            font-weight: 700;
            font-size: 24px;
            color: #6944ff;
            margin-bottom: 15px.
        }
        .instance-card-inf__item {
            padding: 10px 35px;
            min-width: 150px;
        }
        .instance-card-inf__title {
            font-weight: 700;
            font-size: 27px;
            color: #324e63;
        }
        .instance-card-inf__txt {
            font-weight: 500;
            margin-top: 7px;
        }
    </style>
    <title>Azure VM Status</title>
</head>
<body>
    <div class="wrapper">
        <div class="instance-card">
            <div class="instance-card__cnt">
                <div class="instance-card__name">Hello, eu sou o servidor do Marco na $PROVIDER_NAME provisionado pelo Terraform</div>
                <div class="instance-card-inf">
                    <div class="instance-card-inf__item">
                        <div class="instance-card-inf__txt">Instance Location</div>
                        <div class="instance-card-inf__title">$LOCATION</div>
                    </div>
                    <div class="instance-card-inf__item">
                        <div class="instance-card-inf__txt">Instance Public IP</div>
                        <div class="instance-card-inf__title">$PUBLIC_IP</div>
                    </div>
                    <div class="instance-card-inf__item">
                        <div class="instance-card-inf__txt">VM Size</div>
                        <div class="instance-card-inf__title">$VM_SIZE</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
EOF
