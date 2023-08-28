.DEFAULT_GOAL := usage

# user and repo
USER        = $$(whoami)
CURRENT_DIR = $(notdir $(shell pwd))

# terminal colours
RED     = \033[0;31m
GREEN   = \033[0;32m
YELLOW  = \033[0;33m
NC      = \033[0m

.PHONY: install
install:
	bundle
	brew bundle

.PHONY: build
build:
	echo "build step goes here"

.PHONY: demo
demo:
	@echo "\n\tPassword is always ${RED}password${NC}\n"
	@echo "${RED}TODO:${NC} rails credentials demo"
	@echo "${RED}TODO:${NC} SOPS demo"
	@echo "${GREEN}Ansible vault${NC} demo, run:"
	@echo "\t${YELLOW}bin/secrets-init prod${NC}"
	@echo "\t${YELLOW}bin/secrets-edit prod${NC}"
	@echo "\t${GREEN}source bin/secrets-load prod${NC}"
	@echo "\tprintenv | ag ANSIBLE"
	@echo
	@echo "\t\tANSIBLE_VAULT_ENCRYPTED_ENV=the-ansbile-encrypted-env"
	@echo "\t\tANSIBLE_VAULT_VISIBLE_ENV=the-ansible-visible-env"
	@echo
	@echo "${RED}TODO:${NC} EJSON demo"

.PHONY: run
run:
	bin/setup
	bin/rails server

.PHONY: usage
usage:
	@echo
	@echo "Hi ${GREEN}${USER}!${NC} Welcome to ${RED}${CURRENT_DIR}${NC}"
	@echo
	@echo "Getting started"
	@echo
	@echo "${YELLOW}make install${NC}      install"
	@echo "${YELLOW}make build${NC}        build the project"
	@echo
	@echo "${YELLOW}make demo${NC}         demo all the things"
	@echo
	@echo "Development"
	@echo
	@echo "${YELLOW}make run${NC}          run the app"
	@echo
