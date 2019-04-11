FROM ubuntu:12.04

LABEL mantainer=hackwish

ENV DEBIAN_FRONTEND noninteractive

#RUN apt-get upgrade -y

RUN apt-get update && apt-get install -y --no-install-recommends \
	libx11-dev \
	libjpeg62-dev \
	strace \
	libc6 \
	lib32z1 \
	lib32ncurses5 \
	libstdc++5 \
	curl \
	mcrypt \
	git \
	tree \
	ftp \
	apache2 \
	apache2-doc \
	apache2-utils \
	libapache2-mod-php5 \
	php5 \
	php-apc \
	php5-fpm \
	php5-cli \
	php5-pgsql \
	php5-sqlite \
	php5-intl \
	php5-imagick \
	php5-json \
	php5-mcrypt \
	php-mail-mimedecode \
	php-net-url \
	php5-common \
	php5-cli \
	php5-dev \
	php-soap \
	php-pear \
	php5-curl \
	php5-gd \
	php5-mysql \
	&& rm -rf /var/lib/apt/lists/* 

RUN apt-get clean && apt-get autoremove -y

COPY apache_default /etc/apache2/sites-available/default

RUN a2enmod rewrite

RUN a2enmod php5

EXPOSE 80

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

CMD ["/usr/local/bin/entrypoint.sh"]