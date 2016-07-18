FROM nginx:stable-alpine
COPY nginx.conf /etc/nginx/conf.d/app.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]
