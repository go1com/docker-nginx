#!/usr/bin/env bash

sed -i 's/#tcp_nopush/tcp_nodelay/g' /etc/nginx/nginx.conf
sed -i 's/\"$http_x_forwarded_for\"/\"$http_x_forwarded_for\" \"$sent_http_x_request_id\" \"$http_x_request_id\"/' /etc/nginx/nginx.conf
rm /etc/nginx/conf.d/default.conf
cp /app/nginx.conf /etc/nginx/conf.d/app.conf

for i in _ {a..z} {A..Z}; do
    for var in `eval echo "\\${!$i@}"`; do
        if [[ $var == _DOCKER_* ]] ;
        then
            key="${var/_DOCKER_/}"
            val=${!var}
            sed -i "/fastcgi_param SERVER_NAME \$host;/a fastcgi_param $key \"${val}\";" /etc/nginx/conf.d/app.conf
        fi
    done
done

nginx -g "daemon off;"
