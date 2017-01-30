.PHONY = all build test template
COMPOSER_VERSION ?= 1.3.2
COMPOSER_INSTALLER_URL ?= https://raw.githubusercontent.com/composer/getcomposer.org/5fd32f776359b8714e2647ab4cd8a7bed5f3714d/web/installer
COMPOSER_INSTALLER_HASH ?= 55d6ead61b29c7bdee5cccfb50076874187bd9f21f65d8991d46ec5cc90518f447387fb9f76ebae1fbbacf329e583e30

all: build test

build:
	docker build -t composer:1.1 -t composer:1.1.3 1.1
	docker build -t composer:1.2 -t composer:1.2.4 1.2
	docker build -t composer:1.3 -t composer:1.3.2 -t composer:1 -t composer:latest 1.3

test:
	docker run -t composer:1.1.3
	docker run -t composer:1.1.3 /bin/bash --version
	docker run -t composer:1.2.4
	docker run -t composer:1.2.4 /bin/bash --version
	docker run -t composer:1.3.2
	docker run -t composer:1.3.2 /bin/bash --version
	docker run -t composer:1.1
	docker run -t composer:1.1 /bin/bash --version
	docker run -t composer:1.2
	docker run -t composer:1.2 /bin/bash --version
	docker run -t composer:1.3
	docker run -t composer:1.3 /bin/bash --version
	docker run -t composer:1
	docker run -t composer:1 composer --version
	docker run -t composer:1 /bin/bash --version
	docker run -t composer:latest
	docker run -t composer:latest /bin/bash --version

template:
	@sed -e 's@%COMPOSER_VERSION%@$(value COMPOSER_VERSION)@' \
	    -e 's@%COMPOSER_INSTALLER_URL%@$(value COMPOSER_INSTALLER_URL)@' \
	    -e 's@%COMPOSER_INSTALLER_HASH%@$(value COMPOSER_INSTALLER_HASH)@' \
	    Dockerfile.template
