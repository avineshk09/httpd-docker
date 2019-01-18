#!/bin/sh
app_home=$1
cd $app_home
wget https://www.openssl.org/source/openssl-1.0.2d.tar.gz
tar -xf openssl-1.0.2d.tar.gz
echo "extracted openssl"
openssldir=openssl-1.0.2d
cd $openssldir
echo "Current working directory "$PWD
./config --prefix=/opt/openssl --openssldir=/opt/openssl enable-ssl2 enable-ssl3 no-shared
echo "configured openssl, making it.."
echo "Current working directory "$PWD
make depend
make
make install

if [ $? == 0 ]; then
   echo "Openssl is installed successfully."
else
   echo "Error in installing openssl."
   exit 1;
fi

cd $app_home

echo "installing httpd.."  
echo "Current working directory "$PWD
wget http://archive.apache.org/dist/httpd/httpd-2.2.34.tar.gz 
tar -xf httpd-2.2.34.tar.gz
httpddir=httpd-2.2.34
cd $httpddir
echo "Current working directory "$PWD
./configure --with-included-apr --enable-ssl=static --with-ssl=/opt/openssl --prefix=/usr/local/apache2 --enable-so --enable-mods-shared="most cache proxy authn_alias mem_cache file_cache charset_lite dav_lock disk_cache headers rewrite dav"
make 
make install

if [ $? == 0 ]; then
   echo "Httpd is installed successfully."
else
   echo "Error in installing httpd."
   exit 1;
fi

cd $app_home

sed -i \
        -e 's/^#\(ServerName .*80\)/\1/' \
        -e 's/^#\(Include .*httpd-ssl.conf\)/\1/' \
        /usr/local/apache2/conf/httpd.conf

sed -i \
        -e 's/^#\(SSLCertificateFile .*server.crt\)/\1/' \
        -e 's/^#\(SSLCertificateKeyFile .*server.key\)/\1/' \
        -e 's/SSLCipherSuite/#SSLCipherSuite/g'\
        -e 's/SSLProxyCipherSuite/#SSLProxyCipherSuite/g'\
        -e 's/SSLProtocol/#SSLProtocol/g'\
        -e 's/SSLProxyProtocol/#SSLProxyProtocol/g'\
        /usr/local/apache2/conf/extra/httpd-ssl.conf

if [ $? == 0 ]; then
   echo "Httpd app is provision successfully"
else
   echo "Error in provision httpd app"
   exit 1;
fi
