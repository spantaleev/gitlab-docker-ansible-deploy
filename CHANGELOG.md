# 2019-05-28

## Ansible 2.8 compatibility

The playbook now supports the new Ansible 2.8.

A manual change is required to the `inventory/hosts` file, changing the group name from `gitlab-servers` to `gitlab_servers` (dash to underscore).

To avoid doing it manually, run this:
- Linux: `sed -i 's/gitlab-servers/gitlab_servers/g' inventory/hosts`
- Mac: `sed -i '' 's/gitlab-servers/gitlab_servers/g' inventory/hosts`
