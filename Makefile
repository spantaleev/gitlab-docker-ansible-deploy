help: ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

setup-all: ## Sets up all services
	ansible-playbook -i inventory/hosts setup.yml --ask-vault-pass --tags=setup-all

backup: ## Creates a new backup
	ansible-playbook -i inventory/hosts setup.yml --ask-vault-pass --tags=backup

start: ## Restarts services
	ansible-playbook -i inventory/hosts setup.yml --ask-vault-pass --tags=start

update: ## Performs an upgrade after making a backup
	ansible-playbook -i inventory/hosts setup.yml --ask-vault-pass --tags=backup,setup-redis,setup-gitlab,setup-postgres,setup-nginx-proxy,start

setup-all-and-restart: ## Sets up all services and restarts after that
	ansible-playbook -i inventory/hosts setup.yml --ask-vault-pass --tags=setup-all,start
