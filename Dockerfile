FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y

RUN apt -y install nginx
RUN apt-get install -y wget

RUN apt-get install -y php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli \
php7.3-common php7.3-json php7.3-opcache php7.3-readline php7.3-mbstring

RUN apt-get -y install vim

RUN apt-get install -y mariadb-server mariadb-client

RUN apt-get install openssl

EXPOSE 80
EXPOSE 443

COPY ./srcs ./

CMD bash start.sh
