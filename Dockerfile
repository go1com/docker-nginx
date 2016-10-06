FROM openresty/openresty:alpine

ADD https://github.com/pintsized/lua-resty-http/archive/master.tar.gz /
RUN tar -zxf master.tar.gz && rm master.tar.gz && cp -rf lua-resty-http-master/lib/resty/*.lua /usr/local/openresty/lualib/resty && rm -rf lua-resty-http-master
COPY consul.lua /etc/nginx/lua/resty/
COPY nginx.conf /usr/local/openresty/nginx/conf