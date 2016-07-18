nginx as reserved proxy PHP web application
====

- Document root is `/app`.
- PHP fastcgi address: `handler:9000`
- Auto convert `_DOCKER_X` variables to `fastcgi_param X="The value"`.
- Auto remove nginx's `/etc/nginx/conf.d/default.conf`
