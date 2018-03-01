FROM ubuntu

RUN apt-get update

RUN apt-get -y install locales && \
    locale-gen en_US.UTF-8 && \
    export LC_ALL=en_US.UTF-8 && \
    export LANG=en_US.UTF-8 && \
    apt-get -y install --allow-unauthenticated software-properties-common && \
    add-apt-repository ppa:ondrej/php

RUN apt-get update

RUN apt-get install -y python-software-properties

RUN apt-get install -y mc

RUN apt-get install -y apache2

RUN apt-get -y --allow-unauthenticated install  php7.2 \
                                                libapache2-mod-php7.2 \
                                                php7.2-mysql \
                                                php7.1-mcrypt \
                                                php7.2-memcached \
                                                php7.2-memcache \
                                                php7.2-curl php-pear \
                                                php7.2-cli \
                                                php7.2-json \
                                                php7.2-readline \
                                                php7.2-mbstring \
                                                php7.2-gd \
                                                php7.2-intl \
                                                php7.2-xsl

RUN apt-get install -y curl libcurl3 libcurl3-dev

RUN a2enmod rewrite

RUN apt-get install -y git

RUN apt-get install -y nodejs npm

RUN apt-get install -y composer

RUN apt-get install -y nano

RUN apt-get -y autoremove

RUN a2dissite 000-default.conf

RUN a2dissite default-ssl.conf

COPY ./sites-available/vhost.conf /etc/apache2/sites-available/

RUN chown -R www-data:www-data /var/www/

RUN a2ensite vhost.conf

EXPOSE 80

CMD apachectl -DFOREGROUND -k start
