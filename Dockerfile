FROM openresty/openresty:alpine

ADD https://github.com/pintsized/lua-resty-http/archive/v0.09.tar.gz /etc/nginx/lua/
RUN mkdir -p /etc/nginx/lua/resty && cd /etc/nginx/lua/ && tar -zxf v0.09.tar.gz && cp -rf lua-resty-http-0.09/lib/resty/*.lua /etc/nginx/lua/resty
COPY consul.lua /etc/nginx/lua/resty/
COPY nginx.conf /usr/local/openresty/nginx/conf