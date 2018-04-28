# centos7-nginx
Vagrant files that will auto build and initialize a centos7-based NGINX server with some defaults I like.

## SSH Keys
By default the bootstrap.sh file removes the ability to log in via ssh password for all users. Add an authorized_keys file within the resources directory and add any keys you'd like. I don't track this file for security reasons.
