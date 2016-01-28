# The WordPress Theme Tester

For a full tutorial, see [tutorial link].

**Disclaimer**: This project is a proof of concept, and not an official Distelli application.

## Distelli Build Steps
Put the following in your Distelli build steps, in the `Build` section:

```
# download and extract the latest wordpress
wget https://wordpress.org/latest.tar.gz
sudo tar -zxvf latest.tar.gz

# replacing WordPress's default placeholders with environment variables
# Define the environment variables in your Distelli environment
# You can also use this section to add your WordPress auth key, and so on
sudo sed -i 's/database_name_here/\$WP_DB_NAME/g' ./wordpress/wp-config-sample.php
sudo sed -i 's/username_here/\$WP_DB_USER_NAME/g' ./wordpress/wp-config-sample.php
sudo sed -i 's/password_here/\$WP_DB_USER_PASSWORD/g' ./wordpress/wp-config-sample.php
sudo sed -i 's/localhost/\$MYSQL_HOST/g' ./wordpress/wp-config-sample.php
sudo cp ./wordpress/wp-config-sample.php ./wordpress/wp-config.php

# Copying the sample theme
sudo mkdir ./wordpress/wp-content/themes/my-theme
sudo cp my-sample-theme/* ./wordpress/wp-content/themes/my-theme

### Docker Build Commands ###
docker login -u "$DISTELLI_DOCKER_USERNAME" -p "$DISTELLI_DOCKER_PW" -e "$DISTELLI_DOCKER_EMAIL" $DISTELLI_DOCKER_ENDPOINT
docker build --quiet=false -t "$DISTELLI_DOCKER_REPO" $DISTELLI_DOCKER_PATH
docker tag "$DISTELLI_DOCKER_REPO" "$DISTELLI_DOCKER_REPO:$DISTELLI_BUILDNUM"
docker push "$DISTELLI_DOCKER_REPO:$DISTELLI_BUILDNUM"
### End Docker Build Commands ###
```

## Environment Variables
In your Distelli environment, add the following environment variables:
```
MYSQL_HOST=put_your_mysql_hostname_here
WP_DB_NAME=put_your_wordpressdb_name_here
WP_DB_USER_NAME=put_your_wordpressdb_username_here
WP_DB_USER_PASSWORD=put_your_wordpressdb_password_here
```

## Distelli Deployment Steps
Put the following in your Distelli deployment steps, in the `Exec` section:

```
# Note: Distelli environment variables are available only during the deploy script, so you must use -e VAR=$DISTELLI_ENV_VAR to pass environment variables to the Docker container
sudo docker run -p 8081:80 --rm=true -e MYSQL_HOST=$MYSQL_HOST -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD -e WP_DB_NAME=$WP_DB_NAME -e WP_DB_USER_NAME=$WP_DB_USER_NAME -e WP_DB_USER_PASSWORD=$WP_DB_USER_PASSWORD -e WP_AUTH_KEY=$WP_AUTH_KEY "$DISTELLI_DOCKER_REPO:$DISTELLI_BUILDNUM"
```
