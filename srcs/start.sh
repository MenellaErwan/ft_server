#!/bin/bash

cd /srcs/mkcert
chmod +x mkcert
./mkcert -install
./mkcert localhost

cd /var/www/
wget -c https://fr.wordpress.org/latest-fr_FR.tar.gz -O - | tar -xz
wget -c https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz -O - | tar -xz
mv phpMyAdmin-5.0.4-all-languages/ phpmyadmin/
chown -R www-data:www-data /var/www
cd /


service mysql restart
echo "SET password FOR 'root'@'localhost' = password('password');" | mysql -u root
echo "CREATE DATABASE wordpress;" | mysql -u root
echo "CREATE USER 'wordpress'@'localhost';" | mysql -u root
echo "SET password FOR 'wordpress'@'localhost' = password('password');" | mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost' IDENTIFIED BY 'password';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
ln -sf /etc/nginx/sites-available/nginx_index_on.conf /etc/nginx/sites-enabled/ft_server
rm -rf /etc/nginx/sites-enabled/default
service nginx reload
service nginx restart
/etc/init.d/php7.3-fpm start
/etc/init.d/php7.3-fpm status

tail -f /var/log/nginx/access.log -f /var/log/nginx/error.log