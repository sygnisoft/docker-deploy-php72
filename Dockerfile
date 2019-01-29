FROM php:7.2-fpm

RUN apt-get update && buildDeps="nginx libpq-dev libzip-dev gnupg acl git curl nano wget libpng-dev python-dev libgmp-dev ssh rsync libxml2-dev" && apt-get install -y $buildDeps --no-install-recommends
RUN curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh && chmod +x nodesource_setup.sh && bash nodesource_setup.sh
RUN apt-get update && buildDeps="nodejs" && apt-get install -y $buildDeps --no-install-recommends
RUN docker-php-ext-install pdo pdo_pgsql zip bcmath gd calendar gmp pcntl soap
RUN npm install -g yarn
RUN npm install -g bower
RUN npm install -g gulp

RUN wget https://getcomposer.org/composer.phar && mv composer.phar /usr/bin/composer && chmod +x /usr/bin/composer
RUN wget https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/v2.10.3/php-cs-fixer.phar -O php-cs-fixer && chmod a+x php-cs-fixer && mv php-cs-fixer /usr/local/bin/php-cs-fixer
RUN composer global require phing/phing
RUN composer global require phpstan/phpstan

RUN apt-get install -y libsqlite3-dev ruby-full rubygems build-essential && gem install mailcatcher && mailcatcher
RUN echo "memory_limit=-1" > /usr/local/etc/php/conf.d/docker-php-memorylimit.ini
WORKDIR /app
