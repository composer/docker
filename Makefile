COMPOSER_VERSION ?= $(VERSION)
COMPOSER_INSTALLER_URL ?= https://raw.githubusercontent.com/composer/getcomposer.org/cb19f2aa3aeaa2006c0cd69a7ef011eb31463067/web/installer
COMPOSER_INSTALLER_HASH ?= 48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5

.PHONY = all build test template

all: build test

build:
    ifeq (${LATEST}, 1)
	docker build -t composer:$(BRANCH) -t composer:latest -t composer:1 -t composer:$(VERSION) -t composer:$(BRANCH)-$(VARIANT) $(BRANCH)/$(VARIANT)
else
	docker build -t composer:$(BRANCH) -t composer:$(VERSION) -t composer:$(BRANCH)-$(VARIANT) $(BRANCH)/$(VARIANT)
endif
test:
    ifeq (${LATEST}, 1)
	docker run --rm --tty composer:latest --no-ansi | grep 'Composer version $(VERSION)'
	docker run --rm --tty composer:1 --no-ansi | grep 'Composer version $(VERSION)'
	docker run --rm --tty composer:$(BRANCH) --no-ansi | grep 'Composer version $(VERSION)'
	docker run --rm --tty composer:$(BRANCH)-$(VARIANT) --no-ansi | grep 'Composer version $(VERSION)'
else
	docker run --rm --tty composer:$(BRANCH) --no-ansi | grep 'Composer version $(VERSION)'
	docker run --rm --tty composer:$(BRANCH)-$(VARIANT) --no-ansi | grep 'Composer version $(VERSION)'
endif

template:
	@sed --env 's@%COMPOSER_VERSION%@$(COMPOSER_VERSION)@' \
	    --env 's@%COMPOSER_INSTALLER_URL%@$(COMPOSER_INSTALLER_URL)@' \
	    --env 's@%COMPOSER_INSTALLER_HASH%@$(COMPOSER_INSTALLER_HASH)@' \
	    Dockerfile.template
