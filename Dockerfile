FROM debian:buster
RUN apt-get update && apt-get -y upgrade && apt-get install -y nginx mariadb-server php php-mysql php-fpm wget zip libnss3-tools curl
ADD ./srcs/ ./srcs/
COPY /srcs/nginx_index_on.conf /etc/nginx/sites-available/nginx_index_on.conf
COPY /srcs/nginx_index_off.conf /etc/nginx/sites-available/nginx_index_off.conf
EXPOSE 80 443
CMD ["bash", "/srcs/start.sh"]