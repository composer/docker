.PHONY = all build test template
COMPOSER_VERSION ?= 1.3.3
COMPOSER_INSTALLER_URL ?= https://raw.githubusercontent.com/composer/getcomposer.org/da290238de6d63faace0343efbdd5aa9354332c5/web/installer
COMPOSER_INSTALLER_HASH ?= 669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410

all: build test

build:
	docker build -t composer:1.1 -t composer:1.1.3 1.1
	docker build -t composer:1.2 -t composer:1.2.4 1.2
	docker build -t composer:1.3 -t composer:1.3.3 -t composer:1 -t composer:latest 1.3

test:
	docker run -t composer:1.1.3
	docker run -t composer:1.1.3 /bin/bash --version
	docker run -t composer:1.2.4
	docker run -t composer:1.2.4 /bin/bash --version
	docker run -t composer:1.3.2
	docker run -t composer:1.3.2 /bin/bash --version
	docker run -t composer:1.3.3
	docker run -t composer:1.3.3 /bin/bash --version
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
