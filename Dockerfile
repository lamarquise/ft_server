FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y

RUN apt -y install nginx

RUN apt install wget -y

RUN apt-get -y install php7.3 php-mysql php-fpm php-cli php-mbstring

RUN apt-get -y install mariadb-server


WORKDIR /ft_server
COPY . .
