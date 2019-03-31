# Configuring the playbook

Follow these steps inside the playbook directory:

- create a directory to hold your configuration (`mkdir inventory/host_vars/gitlab.<your-domain>`)

- copy the sample configuration file (`cp examples/host-vars.yml inventory/host_vars/gitlab.<your-domain>/vars.yml`)

- edit the configuration file (`inventory/host_vars/gitlab.<your-domain>/vars.yml`) to your liking. You may also take a look at the various `roles/ROLE_NAME_HERE/defaults/main.yml` files and see if there's something you'd like to copy over and override in your `vars.yml` configuration file.

- copy the sample inventory hosts file (`cp examples/hosts inventory/hosts`)

- edit the inventory hosts file (`inventory/hosts`) to your liking
