# Gitlab server setup using Ansible and Docker

This [Ansible](https://www.ansible.com/) playbook can help you set up a [Gitlab](https://about.gitlab.com/) instance:

- on your own Debian/CentOS/RedHat server
- with all services (Gitlab, Postgres, Redis, etc.) being put in [Docker](https://www.docker.com/) containers
- powered by the [sameersbn/docker-gitlab](https://github.com/sameersbn/docker-gitlab) Docker image

SSL certificates are automatically retrieved from [Let's Encrypt](https://letsencrypt.org/).


## Installation

To configure and install Gitlab on your own server, follow the [README in the docs/ directory](docs/README.md).


## Docker images used by this playbook

This playbook sets up your server using the following Docker images:

- [sameersbn/gitlab](https://hub.docker.com/r/sameersbn/gitlab) - the [sameersbn/docker-gitlab](https://github.com/sameersbn/docker-gitlab) Gitlab server image. **Note**: this is not the official [gitlab/gitlab-ce](https://hub.docker.com/r/gitlab/gitlab-ce) Gitlab image. We use the `sameersbn/gitlab` image, because it doesn't force us into running services (Postgres database, Redis server) into the Gitlab container (we run those services in other container ourselves).

- [redis](https://hub.docker.com/_/redis) - the official [Redis](https://redis.io/) image. **Note**: we don't use the [sameersbn/redis](https://hub.docker.com/r/sameersbn/redis) image (which is recommended for [sameersbn/gitlab](https://hub.docker.com/r/sameersbn/gitlab)), because the official one is more up-to-date

- [sameersbn/postgresql](https://hub.docker.com/r/sameersbn/postgresql) - the [sameersbn/docker-postgresql](https://github.com/sameersbn/docker-postgresql) Postgres server. **Note**: we don't use the official Postgres image, because Gitlab requires additional extensions (`pg_trgm`).

- [mwader/postfix-relay](https://hub.docker.com/r/mwader/postfix-relay) - a [Postfix](http://www.postfix.org/) SMTP server we use by default, so that Gitlab can send emails



## Support

- Github issues: [spantaleev/gitlab-docker-ansible-deploy/issues](https://github.com/spantaleev/gitlab-docker-ansible-deploy/issues)
