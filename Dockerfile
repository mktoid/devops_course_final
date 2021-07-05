giy FROM ubuntu:latest

RUN apt-get update \
    && apt-get install -y nginx

COPY index.html /var/www/html/index.html

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]