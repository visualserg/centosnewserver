#!/usr/bin/env bash
DOMAIN=""
EMAIL=""

# Generate SSL certificate for domain
/opt/letsencrypt/letsencrypt-auto certonly --keep-until-expiring --standalone -d $DOMAIN -d www.$DOMAIN --email $EMAIL

# Setup letsencrypt certificates renewing
line="30 2 * * 1 /opt/letsencrypt/letsencrypt-auto renew >> /var/log/letsencrypt-renew.log"
(crontab -u root -l; echo "$line" ) | crontab -u root -


# Rename SSL certificates
# https://community.letsencrypt.org/t/how-to-get-crt-and-key-files-from-i-just-have-pem-files/7348
cd /etc/letsencrypt/live/$DOMAIN/
cp privkey.pem domain.key
cat cert.pem chain.pem > domain.crt
chmod 777 domain.crt
chmod 777 domain.key