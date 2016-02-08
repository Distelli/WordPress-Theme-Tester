#!/bin/bash
set -x

# In PHP's www.conf, replace placeholders with actual environment variables
sed -i "s/\$MYSQL_HOST/$MYSQL_HOST/g" /config-files/www.conf
sed -i "s/\$WP_DB_NAME/$WP_DB_NAME/g" /config-files/www.conf
sed -i "s/\$WP_DB_USER_NAME/$WP_DB_USER_NAME/g" /config-files/www.conf
sed -i "s/\$WP_DB_USER_PASSWORD/$WP_DB_USER_PASSWORD/g" /config-files/www.conf

# Replace the default www.conf with ours
cp -f /config-files/www.conf /etc/php5/fpm/pool.d/www.conf

# Replace the default nginx site with ours
cp -f /config-files/default-nginx /etc/nginx/sites-enabled/default

# Setting ownership of the files
chown www-data:www-data /etc/php5/fpm/pool.d/www.conf
chown -Rf www-data:www-data /usr/share/nginx/html

# Removing the default index.html
rm /usr/share/nginx/html/index.html

# Starting PHP and Nginx. Nginx needs to start in the foreground, to keep the Docker container running
service php5-fpm start && nginx -g 'daemon off;'