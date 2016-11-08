FROM php:7-alpine

RUN apk --no-cache add curl git subversion openssh openssl mercurial tini bash

RUN echo "memory_limit=-1" > "$PHP_INI_DIR/conf.d/memory-limit.ini" \
 && echo "date.timezone=${PHP_TIMEZONE:-UTC}" > "$PHP_INI_DIR/conf.d/date_timezone.ini"

ENV PATH "/composer/vendor/bin:$PATH"
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer
ENV COMPOSER_VERSION 1.1.3

RUN curl -s -f -L -o /tmp/composer-setup.php https://getcomposer.org/installer \
 && curl -s -f -L -o /tmp/composer-setup.sig https://composer.github.io/installer.sig \
 && php -r " \
    \$hash = hash('SHA384', file_get_contents('/tmp/composer-setup.php')); \
    \$signature = trim(file_get_contents('/tmp/composer-setup.sig')); \
    if (!hash_equals(\$signature, \$hash)) { \
        unlink('/tmp/composer-setup.php'); \
        echo 'Integrity check failed, installer is either corrupt or worse.' . PHP_EOL; \
        exit(1); \
    }" \
 && php /tmp/composer-setup.php --no-ansi --install-dir=/usr/bin --filename=composer --version=${COMPOSER_VERSION} \
 && rm /tmp/composer-setup.php \
 && composer --ansi --version --no-interaction

COPY docker-entrypoint.sh /docker-entrypoint.sh

VOLUME /composer

WORKDIR /app

CMD ["--ansi", "--version"]

ENTRYPOINT ["/docker-entrypoint.sh"]
