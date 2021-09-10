FROM nginx
ADD ./nginx.conf /etc/nginx/nginx.conf
ADD ./hydrooj.conf /etc/nginx/conf.d/hydrooj.conf
RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak
