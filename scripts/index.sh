#!/bin/bash
apt update -y
apt install -y apache2

# Detecta o provedor de nuvem
if curl -s -m 2 http://169.254.169.254/latest/meta-data/ >/dev/null 2>&1; then
    # AWS
    PROVIDER_NAME="AWS"
elif curl -s -m 2 http://169.254.169.254/metadata/instance?api-version=2021-02-01 >/dev/null 2>&1; then
    # Azure
    PROVIDER_NAME="Azure"
else
    # Caso não seja AWS nem Azure, atribui um valor padrão
    PROVIDER_NAME="ProvedorDesconhecido"
fi

# Configura e inicia o serviço Apache
systemctl start apache2
systemctl enable apache2

# Obtém os dados de metadados
META_INST_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
META_INST_TYPE=$(curl http://169.254.169.254/latest/meta-data/instance-type)
META_INST_AZ=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone)

# Cria o arquivo HTML com a estrutura fornecida e os dados dinâmicos
cat <<EOF > /var/www/html/index.html
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
            margin-bottom: 15px;
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
    <title>Amazon EC2 Status</title>
</head>
<body>
    <div class="wrapper">
        <div class="instance-card">
            <div class="instance-card__cnt">
                <div class="instance-card__name">Hello, eu sou o servidor do Marco na $PROVIDER_NAME provisionado pelo Terraform</div>
                <div class="instance-card-inf">
                    <div class="instance-card-inf__item">
                        <div class="instance-card-inf__txt">Instance Id</div>
                        <div class="instance-card-inf__title">$META_INST_ID</div>
                    </div>
                    <div class="instance-card-inf__item">
                        <div class="instance-card-inf__txt">Instance Type</div>
                        <div class="instance-card-inf__title">$META_INST_TYPE</div>
                    </div>
                    <div class="instance-card-inf__item">
                        <div class="instance-card-inf__txt">Availability zone</div>
                        <div class="instance-card-inf__title">$META_INST_AZ</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
EOF