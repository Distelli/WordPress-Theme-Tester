# Sample Dockerfile for WordPress
FROM debian:jessie

# Installing nginx and PHP
# To minimize the number of layers, chain the commands using &&
# For readability, use the backslash (\) to add line breaks to the commands
RUN	apt-get update && \
			apt-get install -y php5 \
			php5-fpm \
			php5-mysqlnd \
			nginx

# Copy the WordPress files
COPY ./wordpress/ /usr/share/nginx/html

# Copy the config-files folder, which has the start script, and the
COPY ./config-files /config-files

# Making the container’s port 80 available to the host
EXPOSE 80

# Call the start script
CMD ["/bin/bash", "/config-files/start.sh"]