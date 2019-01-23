CURRENT_BRANCH = 1.8
CURRENT_VERSION = 1.8.0
PREVIOUS_BRANCH = 1.7
PREVIOUS_VERSION = 1.7.3

COMPOSER_VERSION ?= $(CURRENT_VERSION)
COMPOSER_INSTALLER_URL ?= https://raw.githubusercontent.com/composer/getcomposer.org/b107d959a5924af895807021fcef4ffec5a76aa9/web/installer
COMPOSER_INSTALLER_HASH ?= 544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061

.PHONY = all build test template

all: build test

build:
	docker build -t composer:$(CURRENT_BRANCH) -t composer:$(CURRENT_VERSION) -t composer:1 -t composer:latest $(CURRENT_BRANCH)
	docker build -t composer:$(PREVIOUS_BRANCH) -t composer:$(PREVIOUS_VERSION) $(PREVIOUS_BRANCH)

test:
	docker run --rm -t composer:latest --no-ansi | grep 'Composer version $(CURRENT_VERSION)'
	docker run --rm -t composer:1 --no-ansi | grep 'Composer version $(CURRENT_VERSION)'
	docker run --rm -t composer:$(CURRENT_BRANCH) --no-ansi | grep 'Composer version $(CURRENT_VERSION)'
	docker run --rm -t composer:$(PREVIOUS_BRANCH) --no-ansi | grep 'Composer version $(PREVIOUS_VERSION)'

template:
	@sed -e 's@%COMPOSER_VERSION%@$(COMPOSER_VERSION)@' \
	    -e 's@%COMPOSER_INSTALLER_URL%@$(COMPOSER_INSTALLER_URL)@' \
	    -e 's@%COMPOSER_INSTALLER_HASH%@$(COMPOSER_INSTALLER_HASH)@' \
	    Dockerfile.template
