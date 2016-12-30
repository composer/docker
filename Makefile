.PHONY = all build test template
COMPOSER_VERSION ?= 1.3.0
COMPOSER_INSTALLER_URL ?= https://raw.githubusercontent.com/composer/getcomposer.org/0346c9ed3d429536fcc9d722159c10dcd247bcc2/web/installer
COMPOSER_INSTALLER_HASH ?= 61069fe8c6436a4468d0371454cf38a812e451a14ab1691543f25a9627b97ff96d8753d92a00654c21e2212a5ae1ff36

all: build test

build:
	docker build -t composer:1.1 -t composer:1.1.3 1.1
	docker build -t composer:1.2 -t composer:1.2.2 1.2
	docker build -t composer:1.3 -t composer:1.3.0 -t composer:1 -t composer:latest 1.3

test:
	docker run -t composer:1.1.3
	docker run -t composer:1.1.3 /bin/bash --version
	docker run -t composer:1.2.2
	docker run -t composer:1.2.2 /bin/bash --version
	docker run -t composer:1.3.0
	docker run -t composer:1.3.0 /bin/bash --version
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
