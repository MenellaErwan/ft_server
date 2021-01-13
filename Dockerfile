FROM debian:buster
RUN apt-get update && apt-get install -y nginx mariadb-server php php-mysql php-fpm wget unzip libnss3-tools git
ADD ./srcs/ ./srcs/
COPY /srcs/wordpress.conf /etc/nginx/sites-available/wordpress
EXPOSE 80 443
CMD ["bash", "/srcs/start.sh"]