FROM php:7.2-fpm

RUN apt-get update && buildDeps="libpq-dev libzip-dev gnupg acl git curl nano wget libpng-dev libgmp-dev ssh" && apt-get install -y $buildDeps --no-install-recommends
RUN curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh && chmod +x nodesource_setup.sh && bash nodesource_setup.sh
RUN apt-get update && buildDeps="nodejs" && apt-get install -y $buildDeps --no-install-recommends
RUN docker-php-ext-install pdo pdo_pgsql zip bcmath gd calendar gmp
RUN npm install -g yarn

RUN wget https://getcomposer.org/composer.phar && mv composer.phar /usr/bin/composer && chmod +x /usr/bin/composer
RUN wget http://cs.sensiolabs.org/download/php-cs-fixer-v2.phar -O php-cs-fixer && chmod a+x php-cs-fixer && mv php-cs-fixer /usr/local/bin/php-cs-fixer
RUN composer global require phpstan/phpstan

RUN apt-get install -y libsqlite3-dev ruby-full rubygems build-essential && gem install mailcatcher && mailcatcher
WORKDIR /app
