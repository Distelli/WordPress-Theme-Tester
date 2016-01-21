# Sample Dockerfile for WordPress
FROM debian:jessie

# Installing nginx and PHP
# To minimize the number of layers, chain the commands using &&

RUN	apt-get update && \
			apt-get install -y php5 \
			php5-cgi
			php5-mysql \
			nginx

# Copy the WordPress files
COPY ./wordpress/ /usr/share/nginx/html

# Replace the nginx default site with the one we created
COPY default-nginx /etc/nginx/sites-enabled/default

# Remove the nginx default HTML file, and setting ownership to www-data
RUN	rm /usr/share/nginx/html/index.html && \
			chmod 640 /usr/share/nginx/html/wp-config.php && \
			chown www-data:www-data /usr/share/nginx/html/wp-config.php

# Making the container’s port 80 available to the host
EXPOSE 80

# Starting nginx
CMD nginx -g 'daemon off;'