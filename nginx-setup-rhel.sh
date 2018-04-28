yum -y install nginx

# Set up NGINX
# Default webroot is /usr/share/nginx/html
if ! [ -L /usr/share/nginx/html ]; then
  cp -f /tmp/index.html /usr/share/nginx/html
fi

systemctl enable nginx
systemctl start nginx