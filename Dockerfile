FROM php:7.2-fpm

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    apt-get update && apt-get install -y apt-transport-https lsb-release wget && \
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list' && \
    rm -rf /etc/apt/preferences.d/no-debian-php
RUN apt-get update &&  apt-get install -y libpq-dev libzip-dev git curl nano unzip libpng-dev libgmp-dev ssh python-dev openssh-client --no-install-recommends
RUN docker-php-ext-install pdo pdo_pgsql pgsql zip bcmath gd calendar gmp
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - & echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list & apt-get update && apt-get -y install yarn
RUN wget http://cs.sensiolabs.org/download/php-cs-fixer-v2.phar -O php-cs-fixer && chmod a+x php-cs-fixer && mv php-cs-fixer /usr/local/bin/php-cs-fixer && \
    wget https://github.com/phpstan/phpstan-shim/raw/master/phpstan.phar -O phpstan.phar && chmod a+x phpstan.phar && mv phpstan.phar /usr/local/bin/phpstan
MAINTAINER Cezary Mieczkowski <c.mieczkowski@sygnisoft.com>
