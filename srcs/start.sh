#this is a shell scrip that should run a bunch of things




#making a key or something for ssl
mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhost.key -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=emma/CN=localhost"


#setting up config files

#nginx
	#already exists ???
mkdir var/www/localhost

mv ./old_nginx.config etc/nginx/sites-available/default
#ln -s etc/nginx/sites-available/default etc/nginx/sites-enabled
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

#touch /var/www/localhost/index.php
#echo "<?php phpinfo(); ?>" >> /var/www/localhost/index.php

#MYSQL
service mysql start
echo "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" | mysql -u root

#echo "GRANT ALL ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root
#echo "update mysql.user set plugin='password' where user='root';" | mysql -u root
echo "GRANT ALL ON wordpress.* TO 'wordpress_user'@'localhost' IDENTIFIED BY 'password';" | mysql -u root

echo "FLUSH PRIVILEGES;" | mysql -u root

# setting up phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-english.tar.gz
# -v is verbose
tar -zxf phpMyAdmin-4.9.0.1-english.tar.gz
mv phpMyAdmin-4.9.0.1-english /var/www/localhost/phpmyadmin
#now adding the phpmyadmin config file
mv ./config.inc.php var/www/localhost/phpmyadmin
chmod 660 /var/www/localhost/phpmyadmin/config.inc.php
chown -R www-data:www-data /var/www/localhost/phpmyadmin
#now we can start php
service php7.3-fpm start
echo "GRANT ALL ON *.* TO 'erlazo'@'localhost' IDENTIFIED BY 'password'" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

#now wordpress
wget https://wordpress.org/latest.tar.gz
tar -xf latest.tar.gz
mkdir var/www/localhost/wordpress
cp -a wordpress/. /var/www/localhost/wordpress
mv ./wp-config.php /var/www/localhost/wordpress


# now we can run everything
service nginx start
service mysql restart
service php7.3-fpm restart
#sleep infinity
bash








