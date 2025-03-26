FROM php:8.3-fpm

RUN apt-get update && apt-get install default-mysql-client -y

RUN apt-get update && \
    requirements="git cron rsync vim libpng-dev libmcrypt-dev libmcrypt4 libcurl3-dev libfreetype6 libjpeg62-turbo libjpeg62-turbo-dev libpng-dev libfreetype6-dev libicu-dev libxslt1-dev libzip-dev  unzip libc-client-dev libkrb5-dev libonig-dev" && \
    apt-get install -y $requirements && \
    rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install -j$(nproc) pdo_mysql

RUN docker-php-ext-install -j$(nproc) mbstring
RUN docker-php-ext-install -j$(nproc) zip
RUN docker-php-ext-install -j$(nproc) intl
RUN docker-php-ext-install -j$(nproc) xsl
RUN docker-php-ext-install -j$(nproc) soap
RUN docker-php-ext-install -j$(nproc) bcmath
RUN docker-php-ext-install -j$(nproc) opcache
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl
RUN docker-php-ext-install -j$(nproc) imap
RUN docker-php-ext-install -j$(nproc) sockets

RUN printf "\n\n\n" | pecl install redis && \
    docker-php-ext-enable redis

RUN pecl install xdebug
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get update && apt-get install ssmtp -y
RUN echo "sendmail_path = /usr/sbin/ssmtp -t" > /usr/local/etc/php/conf.d/sendmail.ini
RUN echo "mailhub=mailcatcher:1025\nUseTLS=NO\nFromLineOverride=YES" > /etc/ssmtp/ssmtp.conf

RUN docker-php-ext-install -j$(nproc) simplexml
RUN docker-php-ext-install -j$(nproc) xml

#For intell
RUN \
    apt-get update && \
    apt-get install libldap2-dev -y && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-install ldap

# For mac
#RUN \
#    apt-get update && \
#    apt-get install libldap2-dev -y && \
#    rm -rf /var/lib/apt/lists/* && \
#    docker-php-ext-configure ldap --with-libdir=lib/aarch64-linux-gnu/ && \
#    docker-php-ext-install ldap

RUN pecl install mongodb && docker-php-ext-enable mongodb

RUN apt-get update && apt-get install -y libpq-dev && docker-php-ext-install -j$(nproc) pgsql
RUN docker-php-ext-install -j$(nproc) pdo_pgsql

RUN docker-php-ext-configure pcntl --enable-pcntl \
  && docker-php-ext-install pcntl;

SHELL ["/bin/bash", "--login", "-c"]
RUN echo "NPM";
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
RUN nvm install v20.10.0
RUN nvm use v20.10.0
RUN ln -s /root/.nvm/versions/node/v20.10.0/bin/node /bin/nodejs
RUN ln -s /root/.nvm/versions/node/v20.10.0/bin/node /bin/node


RUN apt-get update && apt-get install openssh-server -y

COPY ./conf.d/* /usr/local/etc/php/conf.d/

COPY ./zzz-docker.conf /usr/local/etc/php-fpm.d/zzz-docker.conf

CMD ["php-fpm", "-R"]

WORKDIR /code

RUN apt-get update; \
    apt-get install -y libnss3; \
    apt-get install -y libatk1.0-0; \
    apt-get install -y libatk-bridge2.0-0; \
    apt-get install -y libdrm-dev; \
    apt-get install -y libxkbcommon-x11-0; \
    apt-get install -y libxcomposite-dev; \
    apt-get install -y libxdamage1;


RUN apt-get update; \
    apt-get install -y libmagickwand-dev;
#RUN pecl install imagick; \
#    docker-php-ext-enable imagick;

#https://gist.github.com/Wirone/d5c794b4fef0203146a27687e80588a6 start
ARG IMAGICK_VERSION=3.7.0

RUN curl -L -o /tmp/imagick.tar.gz https://github.com/Imagick/imagick/archive/refs/tags/${IMAGICK_VERSION}.tar.gz \
    && tar --strip-components=1 -xf /tmp/imagick.tar.gz \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini \
    && rm -rf /tmp/*
#https://gist.github.com/Wirone/d5c794b4fef0203146a27687e80588a6 end
RUN docker-php-ext-enable imagick

RUN apt-get update && apt-get install  \
        libpng-dev libjpeg62-turbo-dev libfreetype6-dev \
        jpegoptim optipng pngquant gifsicle -y

RUN apt-get update && \
    apt-get install -y libwebp-dev && \
    docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp

RUN docker-php-ext-install -j$(nproc) gd

RUN apt-get update && apt-get install postgresql-client -y

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
 && locale-gen "en_US.UTF-8"
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8
