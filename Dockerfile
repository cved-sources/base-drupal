FROM cved/base-lamp

LABEL author="cved (cved@protonmail.com)"
LABEL maintainer="cved (cved@protonmail.com)"

ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8

COPY build/drupal/drupal-8.6.7.tar.gz /tmp/
COPY build/drupal/settings.php /tmp/ 
COPY build/drupal/db.sql /

RUN rm -rf /var/www/html/* \
    && tar --strip-components=1 -xzf /tmp/drupal-8.6.7.tar.gz -C /var/www/html \
    && mv -f /tmp/settings.php /var/www/html/sites/default/ \
    && chown -R www-data:www-data /var/www/html/ \
    && rm -f /tmp/*

#COPY build/main.sh /

#EXPOSE 80

#CMD ["/main.sh"]
