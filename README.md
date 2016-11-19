## Installing

Pull the `composer` image from the Docker hub:

``` sh
docker pull composer
```

## Using

Run the `composer` image:

``` sh
docker run --rm -it \
    -v $(pwd):/app \
    composer install
```

You can mount the Composer home directory from your host inside the Container
to share caching and configuration files:

``` sh
docker run --rm -it \
    -v $(pwd):/app \
    -v $COMPOSER_HOME:/composer \
    composer install
```

By default, Composer runs as root inside the container. This can lead to
permission issues on your host filesystem. You can run Composer as yourself:

``` sh
docker run --rm -it \
    -v $(pwd):/app \
    --user $(id -u):$(id -g) \
    composer install
```

## Suggestions

### PHP Extensions

We strive to deliver an image that is as lean as possible, aimed at running
Composer only.

Sometimes dependencies or [composer scripts] require the availability of
certain PHP extensions. In this scenario, you have two options:

* Pass the `--ignore-platform-reqs` and `--no-scripts` flags to `install` or
    `update`:

    ``` sh
    docker run --rm -it \
        -v $(pwd):/app \
        composer install --ignore-platform-reqs --no-scripts
    ```

* Create your own image (possibly by extending `FROM composer`).


### Local runtime/binary

If you want to be able to run `composer` as if it was installed on your host
locally, you can define the following function in your `~/.bashrc`, `~/.zshrc`
or similar:

``` sh
composer () {
    tty=
    tty -s && tty=-t
    docker run \
        $tty \
        -i \
        --rm \
        --user $(id -u):$(id -g) \
        -v $(pwd):/app \
        composer "$@"
}
```

## Resources

* Composer on [Docker Hub][composer_docker_hub]

[composer scripts]: https://getcomposer.org/doc/articles/scripts.md
[composer_docker_hub]: https://hub.docker.com/r/composer/composer/
