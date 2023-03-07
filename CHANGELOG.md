# 2023-03-07

## Not actively maintained anymore

This Ansible playbook is **not actively maintained anymore**. It may be out of date and generally not of very high quality. Send some PRs or get in touch if you'd like to maintain it. Users are generally recommended to migrate their Gitlab installation to the [gitea-docker-ansible-deploy](https://github.com/spantaleev/gitea-docker-ansible-deploy) playbook (powered by [Gitea](https://gitea.io/en-us/), an alternative to Gitlab).


# 2019-05-28

## Ansible 2.8 compatibility

The playbook now supports the new Ansible 2.8.

A manual change is required to the `inventory/hosts` file, changing the group name from `gitlab-servers` to `gitlab_servers` (dash to underscore).

To avoid doing it manually, run this:
- Linux: `sed -i 's/gitlab-servers/gitlab_servers/g' inventory/hosts`
- Mac: `sed -i '' 's/gitlab-servers/gitlab_servers/g' inventory/hosts`
