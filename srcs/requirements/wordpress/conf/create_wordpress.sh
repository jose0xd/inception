#!/bin/sh

if [ -f ./wordpress/wp-config.php ]
then
	echo "wordpress already downloaded"
else
	#Download wordpress
	wget https://wordpress.org/latest.tar.gz
	tar -xzf latest.tar.gz
	rm -rf latest.tar.gz

	#Update configuration file
	rm -rf /etc/php7/php-fpm.d/www.conf
	mv ./www.conf /etc/php7/php-fpm.d/

	#Import env variables in the config file
	cd /var/www/wordpress
	sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
	cp wp-config-sample.php wp-config.php
fi

exec "$@"
