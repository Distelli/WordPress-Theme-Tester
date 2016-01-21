# Sample Dockerfile for WordPress
# Note that installing MySQL in this container functionally makes it available to WordPress only - if you have multiple apps that need MySQL, you should run that in a separate container
# Also note that we're building this image using Debian Jessie as a base image, but there are official Docker images available for both PHP and MySQL

FROM debian:jessie

# Installing nginx and PHP
# To minimize the number of layers, chain the commands using &&
# For readability, use \ and create a new line for every package
# To save the MySQL database, in the docker run command, mount a local directory to /var/lib/mysql in the container

RUN	apt-get update && \
			apt-get install -y php5-fpm \
			php5-mysql \
			nginx

COPY ./wordpress/ /usr/share/nginx/html
COPY ./my-theme/ /usr/share/nginx/html/wp-theme #tbd: verify

# Setting up WordPress
# Seting www-data as the owner of the wp-config file
RUN	chmod 640 /usr/share/nginx/html/wp-config.php && \
    chown www-data:www-data /usr/share/nginx/html/wp-config.php

# Skipping entrypoint for now

CMD ["service","nginx","restart"]