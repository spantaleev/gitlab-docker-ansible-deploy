# Backups

Backups are created daily and automatically. After creating, they're gpg-encrypted (password specified by `gitlab_backup_encryption_password`) and then relocated to `gitlab_backup_directory` (default: `/home/backup/backups`).

7 days worth of backups are kept locally by default (controllable by `gitlab_backup_days_to_keep_locally`).

Granting SSH access to this backup user is possible by defining a list of public keys in the `gitlab_backup_user_authorized_keys` variable.

Creating a backup manually is also possible: `make backup`.


## Remote backups

You can store backups remotely by:

- having them uploaded to [Amazon S3](https://aws.amazon.com/s3/) - see the `gitlab_backup_aws_` variables and the [Note on setting up Amazon S3 backups](#note-on-setting-up-amazon-s3-backups)

- having them uploaded to [Backblaze B2](https://www.backblaze.com/b2/cloud-storage.html) - see the `gitlab_backup_b2` variables

- pulling them from the Gitlab server (`/home/backup/backups`) via SSH

Backups uploaded remotely do not get purged by us.
You're advised to set up the appropriate lifecycle rules or purge them manually.


## Note on setting up Amazon S3 backups

The following is necessary to enable Amazon S3 backups:

- an Amazon S3 bucket in some region (example name: `gitlab.DOMAIN-automatic-backup`)
- a new IAM user to access the bucket
- possibly an S3 bucket lifecycle rule, so that old backups are deleted

The IAM user needs to have the following inline privilege (adjust the bucket name):

	{
		"Version": "2012-10-17",
		"Statement": [
		    {
		        "Effect": "Allow",
		        "Action": [
		            "s3:AbortMultipartUpload",
					"s3:GetBucketAcl",
					"s3:GetBucketLocation",
					"s3:GetObject",
					"s3:GetObjectAcl",
					"s3:ListBucketMultipartUploads",
					"s3:PutObject",
					"s3:PutObjectAcl"
		        ],
		        "Resource": [
		            "arn:aws:s3:::gitlab.DOMAIN-automatic-backup",
		            "arn:aws:s3:::gitlab.DOMAIN-automatic-backup/*"
				]
		    }
		]
	}



## Note on fetching backups via SSH

To get SSH access to the server with the `backup` user, so you can pull the backups from `/home/backup/backups`, you should put your public SSH key(s) in `gitlab_backup_user_authorized_keys`.


## Restoring a backup

- Find an existing **encrypted** backup file that you wish to restore (e.g. `20190331-gitlab.DOMAIN-1554009733_2019_03_31_11.8.3_gitlab_backup.tar.gpg`)

- Decrypt that file (e.g. `gpg -d 20190331-gitlab.DOMAIN-1554009733_2019_03_31_11.8.3_gitlab_backup.tar.gpg > 20190331-gitlab.DOMAIN-1554009733_2019_03_31_11.8.3_gitlab_backup.tar`) using your backup encryption password (specified in `gitlab_backup_encryption_password`)

- Note the version of Gitlab that was used for making the backup. For the example file name (`20190331-gitlab.DOMAIN-1554009733_2019_03_31_11.8.3_gitlab_backup.tar`), it's `11.8.3`.

- Configure your inventory file (`inventory/host_vars/gitlab.DOMAIN/vars.yml`) with a custom variable: `gitlab_gitlab_docker_image_tag: VERSION_HERE`. We need this to ensure that we'll install the same Gitlab version as the one used to make the backup.

- Rebuild the server using the Ansible playbook. See [Installing](installing.md). You may start services if you wish.

- Make sure the `.tar` backup file is available in the `/gitlab/gitlab/data/backups/` directory (e.g. `/gitlab/gitlab/data/backups/20190331-gitlab.DOMAIN-1554009733_2019_03_31_11.8.3_gitlab_backup.tar`)

- Ask the playbook to restore the backup:

```bash
ansible-playbook -i inventory/hosts setup.yml \
--ask-vault-pass \
--tags=restore-backup \
--extra-vars='gitlab_backup_name=20190331-gitlab.DOMAIN-1554009733_2019_03_31_11.8.3_gitlab_backup.tar'
```

- You may now wish to remove your custom version definitions from your `inventory/host_vars/gitlab.DOMAIN/vars.yml` file and re-run the playbook, so you would get upgraded to the latest version. See [Upgrading](upgrading.md).

- The restore operation enables the "Write to authorized_keys file" setting (Admin Area > Settings > Network > Performance Optimization). Consider disabling it, as it doesn't work well with containers.
