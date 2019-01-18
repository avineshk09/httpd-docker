# httpd-docker
Httpd docker machine with SSLv2 and TLS

## Build
      ./app.sh build

## Clean Build

This will delete previously created image and build docker image from scratch.

    ./app.sh cleanbuild

## Run
    ./app.sh serve
    
## Add/delete/modify VirtualHost configurations

Edit **extra-ssl-hosts.conf** file according to your need and **add certificates** to *certs folder* if required. Then build image again using command:

    ./app.sh build

Please don't use clean build as it will build from scratch and will take time.

## Data directory

This is directoy to which certs, scripts and all other data copied.

    /opt/httpd_alpine
   
## Apache httpd home

    /usr/local/apache2/
