ARG PHP_VERSION=8.4
ARG NODE_VERSION=20

########################
# Stage 1: composer deps
########################
FROM composer:2 AS composer-deps
WORKDIR /app
COPY composer.json composer.lock ./
RUN composer install \
      --no-dev --no-scripts --no-autoloader --prefer-dist --no-interaction \
      --ignore-platform-req=ext-intl

########################
# Stage 2: node build (Vite assets)
########################
FROM node:${NODE_VERSION}-alpine AS node-build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY resources/ resources/
COPY vendor/tightenco/ vendor/tightenco/
COPY vite.config.js tailwind.config.js postcss.config.js ./
COPY public/ public/
RUN npm run build

########################
# Stage 3: runtime
########################
FROM php:${PHP_VERSION}-fpm-alpine AS runtime

RUN apk add --no-cache \
        bash icu-libs libzip oniguruma tzdata fcgi ffmpeg \
    && apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS icu-dev libzip-dev oniguruma-dev linux-headers \
    && docker-php-ext-install -j$(nproc) \
        pdo_mysql mbstring bcmath intl zip pcntl sockets opcache \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apk del .build-deps \
    && rm -rf /tmp/pear /var/cache/apk/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY --from=composer-deps /app/vendor ./vendor
COPY --chown=www-data:www-data . .
COPY --from=node-build /app/public/build ./public/build
COPY --from=node-build /app/public/build /opt/build-assets

RUN mkdir -p storage/app/public storage/framework/cache/data storage/framework/sessions \
        storage/framework/testing storage/framework/views storage/logs \
    && rm -f bootstrap/cache/*.php \
    && composer dump-autoload --optimize --classmap-authoritative \
    && php artisan filament:assets \
    && chown -R www-data:www-data storage bootstrap/cache

COPY docker/php/php.ini /usr/local/etc/php/conf.d/zz-app.ini
COPY docker/php/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY docker/php/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 9000
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
