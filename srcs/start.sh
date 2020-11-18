#Sets up right nginx.config file depending on if autoindexing is on or off
if [ "$AUTOINDEX" = "off" ]	;
then cp ./nginx.auto-off.config /etc/nginx/sites-available/default \
	&& touch /var/www/localhost/index.php \
	&& echo "<?php phpinfo(); ?>" >> /var/www/localhost/index.php && echo "Autoindex off";
else cp ./nginx.auto-on.config /etc/nginx/sites-available/default && echo "Autoindex on"; fi

#making ssl key
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhost.key -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=erlazo/CN=localhost"

#MYSQL
service mysql start
echo "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" | mysql -u root
echo "CREATE USER wp_user@localhost IDENTIFIED BY 'password';" | mysql -u root
echo "GRANT ALL ON wordpress.* TO 'wp_user'@'localhost' IDENTIFIED BY 'password';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

#now we can start php
service php7.3-fpm start
echo "GRANT ALL ON *.* TO 'erlazo'@'localhost' IDENTIFIED BY '123';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*

# now we can run everything
service nginx start
service mysql restart
service php7.3-fpm restart
bash
