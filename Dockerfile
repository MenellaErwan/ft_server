FROM debian:buster
RUN apt-get update && apt-get install -y nginx mariadb-server php php-mysql
ADD ./srcs/ .
COPY /srcs/wordpress/ /var/www/
COPY /srcs/wordpress.conf /etc/nginx/sites-available/wordpress.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

