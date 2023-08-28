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
	@echo "${RED}TODO:${NC} rails credentials demo"
	@echo "${RED}TODO:${NC} SOPS demo"
	@echo "${RED}TODO:${NC} Ansible vault demo"
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
