# Sample Dockerfile for WordPress
FROM debian:jessie

# Installing nginx and PHP
# To minimize the number of layers, chain the commands using &&
# For readability, use the backslash (\) to add line breaks to the commands
RUN	apt-get update && \
			apt-get install -y php5 \
			php5-fpm \
			php5-mysql \
			nginx

# Copy the WordPress files
COPY ./wordpress/ /usr/share/nginx/html

# Replace the nginx default site with the one we created
COPY default-nginx /etc/nginx/sites-enabled/default

# Remove the nginx default HTML file
RUN	rm /usr/share/nginx/html/index.html

# Making the container’s port 80 available to the host
EXPOSE 80

# Starting Nginx and PHP
# We’re running Nginx in the foreground, so the container stays running
CMD service php5-fpm start && nginx -g 'daemon off;'