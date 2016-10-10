# Work in progress

> This repo is not yet in use.


# Supported tags and their respective `Dockerfile` links

- `1.2`, `1`, `latest` ([1.2/Dockerfile][])
- `1.2-alpine`, `1-alpine`, `alpine` ([1.2-alpine/Dockerfile][])
- `1.2-php5`, `1-php5`, `php5` ([1.2-php5/Dockerfile][])
- `1.2-php5-alpine`, `1-php5-alpine`, `php5-alpine` ([1.2-php5-alpine/Dockerfile][])
- `master` ([master/Dockerfile][])
- `master-alpine` ([master-alpine/Dockerfile][])
- `master-php5` ([master-php5/Dockerfile][])
- `master-php5-alpine` ([master-php5-alpine/Dockerfile][])


## Installing

Pull the `composer/composer` image from the hub repository:

``` sh
docker pull composer/composer
```

Alternatively, pull a specific variant of `composer/composer`:

``` sh
docker pull composer/composer:alpine
```

## Using

Run the `composer/composer` image:

``` sh
docker run --rm -v $(pwd):/app composer/composer install
```

Alternatively, run a specific variant of `composer/composer`:

``` sh
docker run --rm -v $(pwd):/app composer/composer:alpine install
```

You can mount the Composer home directory from your host inside the Container
to share caching and configuration files:

``` sh
docker run --rm -v $(pwd):/app -v $COMPOSER_HOME:/composer composer/composer install
```

## Suggestions

We strive to deliver an image that is as lean as possible, aimed at running
Composer only.

Sometimes dependencies or [composer scripts] require the availability of certain
PHP extensions. In this scenario, you have two options:

* create your own image (by extending from one of the variants we offer),
* pass the `--ignore-platform-reqs` and `--no-scripts` flags to `install` and
    `update`.

    ``` sh
    docker run --rm -v $(pwd):/app composer/composer install --no-scripts -ignore-platform-reqs
    ```

If you want to be able to just run `composer`, you can define the following
function in your `~/.bashrc`, `~/.zshrc` or similar:

``` sh
function composer () {
    docker run --rm -v $(pwd):/app composer/composer "$@"
}
```

# Image Variants

### `composer/composer:<version>`

This is the defacto image. If you are unsure about what your needs are, you
probably want to use this one.

### `composer/composer:<version>-alpine`

This image is based on the popular [Alpine Linux project][], available in [the
`alpine` official image][]. Alpine Linux is much smaller than most distribution
base images (~5MB), and thus leads to much slimmer images in general.

### `composer/composer:<version>-php5`

This image runs the latest version of PHP 5 instead of PHP 7.

### `composer/composer:<version>-php5-alpine`

This image runs the latest version of PHP 5 instead of PHP 7.


[Composer]: https://getcomposer.org
[Alpine Linux project]: http://alpinelinux.org
[the `alpine` official image]: https://hub.docker.com/_/alpine
[composer scripts]: https://getcomposer.org/doc/articles/scripts.md
[1.2/Dockerfile]: https://github.com/RobLoach/docker-composer/blob/master/1.2/Dockerfile
[1.2-alpine/Dockerfile]: https://github.com/RobLoach/docker-composer/blob/master/1.2/alpine/Dockerfile
[1.2-php5/Dockerfile]: https://github.com/RobLoach/docker-composer/blob/master/1.2/php5/Dockerfile
[1.2-php5-alpine/Dockerfile]: https://github.com/RobLoach/docker-composer/blob/master/1.2/php5/alpine/Dockerfile
[master/Dockerfile]: https://github.com/RobLoach/docker-composer/blob/master/master/Dockerfile
[master-alpine/Dockerfile]: https://github.com/RobLoach/docker-composer/blob/master/master/alpine/Dockerfile
[master-php5/Dockerfile]: https://github.com/RobLoach/docker-composer/blob/master/master/php5/Dockerfile
[master-php5-alpine/Dockerfile]: https://github.com/RobLoach/docker-composer/blob/master/master/php5/alpine/Dockerfile
