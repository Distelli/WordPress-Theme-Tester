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

# Replace the nginx default site with the one we created
COPY default-nginx /etc/nginx/sites-enabled/default

# Replace the default PHP5-FPM config with one that we created, which passes the environment variables
#COPY www.conf /etc/php5/fpm/pool.d/www.conf

# Remove the nginx default HTML file and telling php.ini to check environment variables
#RUN	rm /usr/share/nginx/html/index.html && \
#			sed -i 's/"GPCS"/"EGPCS"/g' /etc/php5/fpm/php.ini && \


# Making the container’s port 80 available to the host
EXPOSE 80

# Starting Nginx and PHP
# We’re running Nginx in the foreground, so the container stays running
CMD service php5-fpm start && nginx -g 'daemon off;'