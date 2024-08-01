#!/bin/sh

rm /usr/local/etc/php/conf.d/xdebug.ini;
touch /usr/local/etc/php/conf.d/xdebug.ini

echo "zend_extension=xdebug.so" >> /usr/local/etc/php/conf.d/xdebug.ini
echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/xdebug.ini
echo "xdebug.idekey=PHPSTORM" >> /usr/local/etc/php/conf.d/xdebug.ini
echo "xdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/xdebug.ini
echo "xdebug.log="/var/log/php/xdebug.log"" >> /usr/local/etc/php/conf.d/xdebug.ini
echo "xdebug.client_port=9003" >> /usr/local/etc/php/conf.d/xdebug.ini
echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/xdebug.ini
#echo "xdebug.client_host=172.19.0.1" >> /usr/local/etc/php/conf.d/xdebug.ini

kill -USR2 1;