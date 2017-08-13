.PHONY = all build test template
COMPOSER_VERSION ?= 1.5.1
COMPOSER_INSTALLER_URL ?= https://raw.githubusercontent.com/composer/getcomposer.org/da290238de6d63faace0343efbdd5aa9354332c5/web/installer
COMPOSER_INSTALLER_HASH ?= 669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410

all: build test

build:
	docker build -t composer:1.5 -t composer:1.5.1 -t composer:1 -t composer:latest 1.5
	docker build -t composer:1.4 -t composer:1.4.3 1.4

test:
	docker run -t composer:latest --no-ansi | grep 'Composer version 1.5.1'
	docker run -t composer:latest /bin/bash --version
	docker run -t composer:1 --no-ansi | grep 'Composer version 1.5.1'
	docker run -t composer:1 /bin/bash --version
	docker run -t composer:1.5 --no-ansi | grep 'Composer version 1.5.1'
	docker run -t composer:1.5 /bin/bash --version
	docker run -t composer:1.5.0 --no-ansi | grep 'Composer version 1.5.0'
	docker run -t composer:1.5.0 /bin/bash --version
	docker run -t composer:1.4 --no-ansi | grep 'Composer version 1.4.3'
	docker run -t composer:1.4 /bin/bash --version
	docker run -t composer:1.4.3 --no-ansi | grep 'Composer version 1.4.3'
	docker run -t composer:1.4.3 /bin/bash --version

template:
	@sed -e 's@%COMPOSER_VERSION%@$(value COMPOSER_VERSION)@' \
	    -e 's@%COMPOSER_INSTALLER_URL%@$(value COMPOSER_INSTALLER_URL)@' \
	    -e 's@%COMPOSER_INSTALLER_HASH%@$(value COMPOSER_INSTALLER_HASH)@' \
	    Dockerfile.template
