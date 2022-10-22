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
	mysql_install_db --user=$MYSQL_USER --ldata=/var/lib/mysql > /dev/null

	# create temp file
	tfile=`mktemp`
	if [ ! -f "$tfile" ]; then
	    return 1
	fi

	# save sql
	cat << EOF > $tfile
GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
FLUSH PRIVILEGES;
EOF

	#Import database
	#mysql -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /usr/local/bin/wordpress.sql

	#/usr/bin/mysqld --user=$MYSQL_USER --bootstrap --verbose=0 --skip-networking=0 < $tfile
	/usr/bin/mysqld --bootstrap --verbose=0 --skip-networking=0 < $tfile
	rm -f $tfile
fi

exec /usr/bin/mysqld --user=$MYSQL_USER --console --skip-networking=0