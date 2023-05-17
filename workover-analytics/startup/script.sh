#!/bin/bash
dir="/var/www/html/Animo-Backend"
if [ ! -d "$dir" ]; then
    gcloud secrets versions access latest --secret=backend_id_rsa >> ~/.ssh/id_rsa;   
    gcloud secrets versions access latest --secret=backend_id_rsa_pub >> ~/.ssh/id_rsa.pub;
    chmod 600 ~/.ssh/id_rsa;
    chmod 600 ~/.ssh/id_rsa.pub; 
    cd /var/www/html/;
    sudo chown -R mngoga:mngoga /var/www/;
    ssh-keyscan github.com >> ~/.ssh/known_hosts;
    eval $(ssh-agent);
    ssh-add ~/.ssh/id_rsa;
    git clone git@github.com:Astra-Innovations/Animo-Backend.git;
    cd /var/www/html/Animo-Backend/backend;
    git checkout;
    git pull;
    git checkout Upgrade-libraries;
    git pull;
    python -m venv env;
    . env/bin/activate;
    pip install -r requirements.txt --use-pep517;
    cd /var/www/html/Animo-Backend/backend/astra;
    chmod u+x /var/www/html/Animo-Backend/backend/astra/vm_creation_script.py;
    python3 /var/www/html/Animo-Backend/backend/astra/vm_creation_script.py;
    sh -c "echo \"MACHINE_TYPE='Workover Analytics'\" >> /var/www/html/Animo-Backend/backend/astra/.env";
    sh -c "echo \"DEPLOYMENT_TIER='TESTING'\" >> /var/www/html/Animo-Backend/backend/astra/.env";
    sh -c "echo \"PARTNER_ID=12\" >> /var/www/html/Animo-Backend/backend/astra/.env";
    sh -c "echo \"WITSML_CONNECTION_ID=1\" >> /var/www/html/Animo-Backend/backend/astra/.env";
    sudo chown -R www-data:www-data /var/www/html/; 
    sudo a2enmod rewrite;
    sudo a2enmod proxy_http;
    sudo service apache2 restart;
    sudo a2enmod ssl;
    sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt -subj "/C=US/ST=Texas/L=Houston/O=My Organization/OU=My Department/CN=animo-ap.pro/emailAddress=contact@astra-ai.com";
    sudo a2ensite 000-default-ssl;
    sudo service apache2 restart;
    sudo apt-get update -y && sudo apt-get upgrade -y;
    fi
