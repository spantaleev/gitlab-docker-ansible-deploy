# Installing

After [configuring the playbook](configuring-playbook.md), you're ready to install.

Run the playbook: `make setup-all`.

After installing, you can start services: `make start`.
Gitlab may take a minute or so to actually start.


## Initial Gitlab setup

After some time, you should be able to access your new Gitlab instance at: `https://gitlab.DOMAIN`.
Going there, you'll be taken to a "set new password" page, which will let you assign a password for the default `root` user.

Feel free to create more users after that and even delete this `root` user.


## Post-install configuration

After you're convinced that Gitlab is running, you should finish-up your configuration (what you started doing during [configuring](configuring-playbook.md)).

In the future, if you are to restore a backup or otherwise rebuild the Gitlab server, you'd wish to also restore the SSH host keys for the Gitlab Shell server.

The backup/restore process doesn't take care of those, so you should let the playbook help you.
Edit your `inventory/host_vars/gitlab.<your-domain>/vars.yml` file and uncomment and populate the `gitlab_shell_ssh_host_keys` variable.

The SSH host keys are in `/gitlab/gitlab/data/ssh` (`gitlab_gitlab_data_ssh_dir_path`) on the server.
You can paste the content for each key in the corresponding place in `gitlab_shell_ssh_host_keys`.
We recommend encrypting the values using `ansible-vault encrypt_string`.
