.PHONY = all build test
COMPOSER_VERSION ?= 1.2.2
COMPOSER_INSTALLER_URL ?= https://raw.githubusercontent.com/composer/getcomposer.org/9184c4b85ed6ada94a298cf54e55cc252c970c28/web/installer
COMPOSER_INSTALLER_HASH ?= aa96f26c2b67226a324c27919f1eb05f21c248b987e6195cad9690d5c1ff713d53020a02ac8c217dbf90a7eacc9d141d

all: build test

build:
	docker build -t composer:1.1 -t composer:1.1.3 1.1
	docker build -t composer:1 -t composer:1.2 -t composer:1.2.2 -t composer:latest 1.2

test:
	docker run composer:1
	docker run composer:1 /bin/bash --version
	docker run composer:1.1
	docker run composer:1.1 /bin/bash --version
	docker run composer:1.1.3
	docker run composer:1.1.3 /bin/bash --version
	docker run composer:1.2
	docker run composer:1.2 /bin/bash --version
	docker run composer:1.2.2
	docker run composer:1.2.2 /bin/bash --version
	docker run composer:latest
	docker run composer:latest /bin/bash --version

template:
	@sed -e 's@%COMPOSER_VERSION%@$(value COMPOSER_VERSION)@' \
	    -e 's@%COMPOSER_INSTALLER_URL%@$(value COMPOSER_INSTALLER_URL)@' \
	    -e 's@%COMPOSER_INSTALLER_HASH%@$(value COMPOSER_INSTALLER_HASH)@' \
	    Dockerfile.template
