.PHONY = all build test

all: build test

build: build/1.1 build/1.2
	docker build -t composer:1 1.2
	docker build -t composer:latest 1.2

test: test/1.1 test/1.2

build/%:
	docker build -t "composer:$*" "$*"

test/%:
	docker run "composer:$*"
	docker run "composer:$*" /bin/bash --version
