# Sample Dockerfile for WordPress
FROM debian:jessie

# Installing nginx and PHP
# To minimize the number of layers, chain the commands using &&

RUN	apt-get update && \
			apt-get install -y php5-fpm \
			php5-mysql \
			nginx

COPY ./wordpress/ /usr/share/nginx/html

# Set ownership to www-data
RUN	chmod 640 /usr/share/nginx/html/wp-config.php && \
    chown www-data:www-data /usr/share/nginx/html/wp-config.php

# Entrypoint
# ENTRYPOINT ["/bin/bash"]

# Starting nginx
CMD service nginx start