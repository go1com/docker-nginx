#!/bin/sh

sed -i 's/#tcp_nopush/tcp_nodelay/g' /etc/nginx/nginx.conf
sed -i 's/\"$http_x_forwarded_for\"/\"$http_x_forwarded_for\" \"$sent_http_x_request_id\" \"$http_x_request_id\"/' /etc/nginx/nginx.conf
rm /etc/nginx/conf.d/default.conf || true

vars=`set | grep _DOCKER_`
vars=$(echo $vars | tr "\n")

for var in $vars
do
    key=$(echo "$var" | sed -E 's/_DOCKER_([^=]+).+/\1/g')
    var=$(echo "$var" | sed -E 's/_DOCKER_([^=]+).+/_DOCKER_\1/g')
    eval val=\$$var
    sed -i "/fastcgi_param SERVER_NAME \$host;/a fastcgi_param $key \"$val\";" /etc/nginx/conf.d/app.conf
done

nginx -g "daemon off;"
