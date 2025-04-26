FROM php:8.1-apache-bullseye

ENV OJS_VERSION=3.4.0-5 \
    OJS_DIR=/var/www/html

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    gosu \
    mariadb-client \
    gettext \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    wget \
    libicu-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql zip intl


# Enable Apache rewrite module
RUN a2enmod rewrite

# Copy Apache log redirection config
COPY apache-logs.conf /etc/apache2/conf-available/apache-logs.conf
RUN a2enconf apache-logs

# Download and install OJS
RUN wget https://pkp.sfu.ca/ojs/download/ojs-${OJS_VERSION}.tar.gz -O /tmp/ojs.tar.gz \
    && tar -xzf /tmp/ojs.tar.gz -C /tmp \
    && rm /tmp/ojs.tar.gz \
    && mv /tmp/ojs-${OJS_VERSION}/* /var/www/html/ \
    && mv /tmp/ojs-${OJS_VERSION}/.[!.]* /var/www/html/ || true \
    && rm -rf /tmp/ojs-${OJS_VERSION}

# Create important writable folders
RUN mkdir -p $OJS_DIR/public $OJS_DIR/cache $OJS_DIR/files \
    && chown -R www-data:www-data $OJS_DIR

# Copy PHP settings
COPY php.ini /usr/local/etc/php/

# Expose port 80
EXPOSE 80

# Copy the config template
COPY config.inc.php.template /var/www/html/config/config.inc.php.template

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Override entrypoint
ENTRYPOINT ["entrypoint.sh"]
