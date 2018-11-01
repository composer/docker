COMPOSER_VERSION ?= 1.7.3
COMPOSER_INSTALLER_URL ?= https://raw.githubusercontent.com/composer/getcomposer.org/b107d959a5924af895807021fcef4ffec5a76aa9/web/installer
COMPOSER_INSTALLER_HASH ?= 544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061

.PHONY = all build test template

all: build test

build:
	docker build -t composer:1.7 -t composer:1.7.3 -t composer:1 -t composer:latest 1.7
	docker build -t composer:1.6 -t composer:1.6.5 1.6

test:
	docker run -t composer:latest --no-ansi | grep 'Composer version 1.7.3'
	docker run -t composer:1 --no-ansi | grep 'Composer version 1.7.3'
	docker run -t composer:1.7 --no-ansi | grep 'Composer version 1.7.3'
	docker run -t composer:1.6 --no-ansi | grep 'Composer version 1.6.5'

template:
	@sed -e 's@%COMPOSER_VERSION%@$(value COMPOSER_VERSION)@' \
	    -e 's@%COMPOSER_INSTALLER_URL%@$(value COMPOSER_INSTALLER_URL)@' \
	    -e 's@%COMPOSER_INSTALLER_HASH%@$(value COMPOSER_INSTALLER_HASH)@' \
	    Dockerfile.template
