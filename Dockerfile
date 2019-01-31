FROM cved/base-lamp

LABEL author="cved (cved@protonmail.com)"
LABEL maintainer="cved (cved@protonmail.com)"

ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8

COPY build/apache2.conf /etc/apache2/
COPY build/drupal/drupal-8.6.7.tar.gz /tmp/
COPY build/drupal/settings.php /tmp/ 
COPY build/drupal/db.sql /tmp/

RUN a2enmod rewrite \
    && rm -rf /var/www/html/* \
    && tar --strip-components=1 -xzf /tmp/drupal-8.6.7.tar.gz -C /var/www/html \
    && mv -f /tmp/settings.php /var/www/html/sites/default/ \
    && chown -R www-data:www-data /var/www/html/ \
    && /etc/init.d/mysql start \
    && mysql -e "CREATE DATABASE drupal DEFAULT CHARACTER SET utf8;" -uroot -proot \
    && mysql -e "use drupal;source /tmp/db.sql;" -uroot -proot \
    && rm -f /tmp/*

EXPOSE 80

ENTRYPOINT ["/main.sh"]
