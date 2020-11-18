FROM debian:buster

ENV AUTOINDEX on

RUN apt-get update
RUN apt-get upgrade -y

RUN apt -y install nginx
RUN apt-get install -y wget

RUN apt-get install -y php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli \
php7.3-common php7.3-json php7.3-opcache php7.3-readline php7.3-mbstring

RUN apt-get -y install vim

RUN apt-get install -y mariadb-server mariadb-client

RUN apt-get install openssl

COPY ./srcs ./

RUN mkdir var/www/localhost \
	&& mkdir /etc/nginx/ssl

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-english.tar.gz \
	&& tar -xzf phpMyAdmin-5.0.2-english.tar.gz \
	&& mv phpMyAdmin-5.0.2-english /var/www/localhost/phpmyadmin \
	&& mv ./config.inc.php var/www/localhost/phpmyadmin \
	&& rm -rf phpMyAdmin-5.0.2-english.tar.gz

RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz \
	&& mv wordpress /var/www/localhost/wordpress \
    && mv ./wp-config.php /var/www/localhost/wordpress \
    && rm -rf latest.tar.gz

EXPOSE 80
EXPOSE 443

CMD bash start.sh
