# Prerequisites

- **CentOS** (7.0+) or **Debian** (9/Stretch+) server. This playbook takes over your server (ports `tcp/22`, `tcp/80` and `tcp/443`), so running other services on it is not desirable

- the machine's SSH server needs to be moved to another port (e.g. `222`), so that port `22` would be available for Gitlab's own purposes

- [Python](https://www.python.org/) being installed on the server. Most distributions install Python by default, but some don't

- the [Ansible](http://ansible.com/) program being installed on your own computer. It's used to run this playbook and configures your server for you

- a `cron`-like tool installed on the server such as `cron` or `anacron` to automatically schedule the Let's Encrypt SSL certificates
