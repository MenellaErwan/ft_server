#!/bin/sh

if ! cmp -s /etc/nginx/sites-enabled/ft_server nginx_index_off.conf
then
	echo "index OFF"
	ln -sf /etc/nginx/sites-available/nginx_index_off.conf /etc/nginx/sites-enabled/ft_server
	cp /var/www/html/index.nginx-debian.html /var/www/index.html
elif ! cmp -s /etc/nginx/sites-enabled/ft_server nginx_index_on.conf
then
	echo "index ON"
	ln -sf /etc/nginx/sites-available/nginx_index_on.conf /etc/nginx/sites-enabled/ft_server
	rm -rf /var/www/index.html
fi

service nginx reload
service nginx restart