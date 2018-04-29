yum -y install epel-release
yum -y install nginx certbot-nginx

# Set up NGINX
# Default webroot is /usr/share/nginx/html
if ! [ -L /usr/share/nginx/html ]; then
  cp -f /tmp/nginx/index.html /usr/share/nginx/html
fi

cp -f /tmp/nginx/nginx.conf /etc/nginx/nginx.conf

# SSL Setup
mkdir -p /etc/nginx/ssl
openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

# Create a temporary ssl cert until the letsencrypt one is installed
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=US/ST=Michigan/L=Test/O=OrgName/OU=IT Department/CN=example.com"

systemctl enable nginx
systemctl start nginx

# Needed for SELinux to allow proxy connections
setsebool -P httpd_can_network_connect 1

# Firewall config
systemctl start firewalld 
systemctl enable firewalld 
firewall-cmd --add-service=http
firewall-cmd --add-service=https
firewall-cmd --runtime-to-permanent

# For final SSL configuration you'll need to login and run certbot-nginx
#certbot --nginx -d boogle.cloud -d www.boogle.cloud
# Then restart nginx to use the new key
#systemctl restart nginx

# Auto renew every two months by adding this to root crontab
# 0 3 28 2,4,6,8,10,12 * /usr/bin/certbot renew --quiet