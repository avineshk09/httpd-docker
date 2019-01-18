
opt=$1
if [ "$opt" == "build" ]; then
   echo "building httpd app"
   docker build -t httpd_alpine .
   if [ $? == 0 ]; then
    echo "httpd_alpine build successfully."
   fi
fi

if [ "$opt" == "cleanbuild" ]; then
   echo "Cleaning existing data."
   docker stop httpd_alpine_ssl
   docker rm httpd_alpine_ssl
   docker rmi httpd_alpine
    if [ $? == 0 ]; then
     echo "Done."
   fi
   echo "building httpd app"
   docker build -t httpd_alpine .
   if [ $? == 0 ]; then
    echo "httpd_alpine build successfully."
   fi
fi

if [ "$opt" == "serve" ]; then
   docker stop httpd_alpine_ssl
   docker rm httpd_alpine_ssl
   echo "running httpd app"
   docker run -dit --name httpd_alpine_ssl -p 1200-1250:1200-1250 httpd_alpine 
   if [ $? == 0 ]; then
     echo "Done."
   fi
fi
