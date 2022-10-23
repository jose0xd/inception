#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

#Check if the database exists

if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then 
	echo "Database already exists"
else
	
	# init database
	mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null

	mysqld --user=mysql --console --skip-networking=0 &

	sleep 1
	echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot

	#Create database and user for wordpress
	echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;" | mysql -uroot
	echo "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot

	#Import database
	mysql -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /scripts/wordpress.sql

fi

exec /usr/bin/mysqld --user=mysql --console --skip-networking=0
