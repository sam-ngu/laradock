#!/bin/bash

if [ ! -f /etc/nginx/ssl/default.crt ]; then
    openssl genrsa -out "/etc/nginx/ssl/default.key" 2048
    openssl req -new -key "/etc/nginx/ssl/default.key" -out "/etc/nginx/ssl/default.csr" -subj "/CN=default/O=default/C=UK"
    openssl x509 -req -days 365 -in "/etc/nginx/ssl/default.csr" -signkey "/etc/nginx/ssl/default.key" -out "/etc/nginx/ssl/default.crt"
fi

# for production purpose
domains=(acadea.com.au www.acadea.com.au)
path="/etc/letsencrypt/live/$domains"
mkdir -p $path
if [ ! -f $path/privkey.pem ]; then
openssl req -x509 -nodes -newkey rsa:1024 -days 1\
  -keyout "$path/privkey.pem" \
  -out "$path/fullchain.pem" \
  -subj "/CN=localhost"
fi


# cron job to restart nginx every 6 hour
(crontab -l ; echo "0 0 */4 * * nginx -s reload") | crontab -

# Start crond in background
crond -l 2 -b


#* * * * * root nginx -s reload >> /var/log/cron.log

# Start nginx in foreground
echo "NGINX started, daemon will restart every 6 hours now.";
nginx

