.PHONY = all build test

all: build test

build: build/1.1.3 build/1.2.1 build/snapshot
test: test/1.1.3 test/1.2.1 test/snapshot

build/%:
	docker build -t "composer:$*" "$*"

test/%:
	docker run "composer:$*"

tpl/%:
	mkdir "$*"
	cp Dockerfile.template "$*/Dockerfile"
	sed -ri 's/%%COMPOSER_VERSION%%/'"$*"'/' "$*/Dockerfile"
