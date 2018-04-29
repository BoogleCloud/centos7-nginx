yum -y install epel-release
yum -y install nginx certbot-nginx

# Set up NGINX
# Default webroot is /usr/share/nginx/html
if ! [ -L /usr/share/nginx/html ]; then
  cp -f /tmp/nginx/index.html /usr/share/nginx/html
fi

cp -f /tmp/nginx/nginx.conf /etc/nginx/nginx.conf

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
