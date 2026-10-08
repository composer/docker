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
- :robot: [Renovate] opens a pull request bumping the relevant `Dockerfile`s
- :writing_hand: pull request is reviewed and merged
- :writing_hand: a pull request is submitted to the [official images repository]
- :writing_hand: pull request is merged, resulting in new release being added to [Docker Hub (official)]


## Community / Vendor Image

The "community" image release workflow is as follows:

- :robot: a new tag is pushed to [Composer repository]
- :robot: [Renovate] opens a pull request bumping the relevant `Dockerfile`s
- :writing_hand: pull request is reviewed and merged
- :robot: [docker workflows] builds and pushes new release to [Docker Hub (community)]
- :robot: [docker workflows] builds and pushes new release to [Amazon Public ECR]
- :robot: [docker workflows] builds and pushes new release to [GHCR]

[composer repository]: https://github.com/composer/composer
[docker repository]: https://github.com/composer/docker
[official images repository]: https://github.com/docker-library/official-images/
[renovate]: https://github.com/composer/docker/blob/main/.github/renovate.json
[docker workflows]: https://github.com/composer/docker/tree/main/.github/workflows
[Amazon Public ECR]: https://gallery.ecr.aws/composer/composer
[GHCR]: https://github.com/composer/docker/pkgs/container/docker
[Docker Hub (official)]: https://hub.docker.com/_/composer
[Docker Hub (community)]: https://hub.docker.com/r/composer/composer
