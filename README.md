# Docker Images

Source behind the following images:

- DockerHub https://hub.docker.com/_/composer (official)
- DockerHub https://hub.docker.com/r/composer/composer (community)
- AWS ECR https://gallery.ecr.aws/composer/composer (community)
- GHCR https://github.com/composer/docker/pkgs/container/docker (community)

Docker Hub documentation can be found at https://github.com/docker-library/docs/tree/master/composer


## Official Image (Docker Hub only)

The "official" image release workflow is as follows:

- :robot: a new tag is pushed to [Composer repository]
- :robot: [release workflow] on [Composer repository] creates an issue regarding new tag on [Docker repository]
- :writing_hand: modification to relevant `Dockerfile`s is pushed/merged
- :writing_hand: a pull request is submitted to the [official images repository]
- :writing_hand: pull request is merged, resulting in new release being added to [Docker Hub (official)]


## Community / Vendor Image

The "community" image release workflow is as follows:

- :robot: a new tag is pushed to [Composer repository]
- :robot: [release workflow] on [Composer repository] creates an issue regarding new tag on [Docker repository]
- :writing_hand: modification to relevant `Dockerfile`s is pushed/merged
- :robot: [docker workflows] builds and pushes new release to [Docker Hub (community)]
- :robot: [docker workflows] builds and pushes new release to [Amazon Public ECR]
- :robot: [docker workflows] builds and pushes new release to [GHCR]

[composer repository]: https://github.com/composer/composer
[docker repository]: https://github.com/composer/docker
[official images repository]: https://github.com/docker-library/official-images/
[release workflow]: https://github.com/composer/composer/blob/main/.github/workflows/release.yml
[docker workflows]: https://github.com/composer/docker/tree/main/.github/workflows
[Amazon Public ECR]: https://gallery.ecr.aws/composer/composer
[GHCR]: https://github.com/composer/docker/pkgs/container/docker
[Docker Hub (official)]: https://hub.docker.com/_/composer
[Docker Hub (community)]: https://hub.docker.com/r/composer/composer
