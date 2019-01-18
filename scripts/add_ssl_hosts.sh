#!/bin/sh

## to add extra hosts to httpd-ssl.conf
apphome=$1
cd $apphome
httpd_home=/usr/local/apache2

cp $httpd_home/conf/extra/httpd-ssl.conf $httpd_home/conf/extra/httpd-ssl.conf.bak
cp $httpd_home/conf/extra/httpd-ssl.conf httpd-ssl.conf
cat httpd-ssl.conf > httpd-ssl.conf.1
cat extra-ssl-hosts.conf >> httpd-ssl.conf.1
cp httpd-ssl.conf.1 $httpd_home/conf/extra/httpd-ssl.conf

if [ $? == 0 ]; then
   echo "added ssl hosts successfully"
else
   echo "Error in adding ssl hosts"
   exit 1;
fi


