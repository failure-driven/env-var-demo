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

.PHONY: slides
slides:
	@slides PRESENTATION.md

.env.local:
	@echo "DOT_ENV_OVERWRITTEN_VISIBLE=\"DotEnv overwritten visible key set in .env.local\"\n"\
		"DOT_ENV_OVERWRITTEN_SECRET=\"DotEnv overwritten secret key set in .env.local\"" > \
		.env.local

.PHONY: demo-dotenv
demo-dotenv:
	@echo "${GREEN}DotEnv${NC} demo, run:\n" \
		"\t${YELLOW}cat .env${NC}\n" \
		"\t${YELLOW}cat .env.development${NC}\n" \
		"\t${YELLOW}make .env.local${NC}\n" \
		"\t${YELLOW}cat .env.local${NC}\n" \
		"\t${YELLOW}bin/rails restart${NC}\n"

.PHONY: demo-rails-credentials
demo-rails-credentials:
	@echo "${RED}TODO:${NC} rails credentials demo"
	@echo

.PHONY: demo-sops
demo-sops:
	@echo "${RED}TODO:${NC} SOPS demo"
	@echo

.PHONY: demo-ansible-vault
demo-ansible-vault:
	@echo "${GREEN}Ansible vault${NC} demo, run:\n" \
		"\t${YELLOW}bin/secrets-init prod${NC}\n" \
		"\t${YELLOW}bin/secrets-edit prod${NC}\n" \
		"\tpassword is: ${RED}password${NC}\n" \
		"\t${GREEN}source bin/secrets-load prod${NC}\n" \
		"\tset | ag ANSIBLE\n" \
		"\n" \
		"\t\tANSIBLE_VAULT_ENCRYPTED_ENV=the-ansbile-encrypted-env\n" \
		"\t\tANSIBLE_VAULT_VISIBLE_ENV=the-ansible-visible-env"
	@echo

.PHONY: demo-ejson
demo-ejson:
	@echo "${GREEN}EJSON${NC} demo\n" \
		"\t# place the keys somewhere like /opt/ejson/keys\n" \
		"\tmkdir -p env/ejson_keydir\n" \
		"\tejson -keydir env/ejson_keydir keygen -w\n" \
		"\t    7baa8909...\n" \
		"\tcat <<EOF > env/prod.ejson\n" \
		"\t{\n" \
		"\t    \"_public_key\": \"7baa89...\",\n" \
		"\t    \"environment\": {\n" \
		"\t        \"_EJSON_VISIBLE\": \"EJSON visible key\",\n" \
		"\t        \"EJSON_ENCRPYTED\": \"EJSON encrypted key\"\n" \
		"\t    }\n" \
		"\t}\n" \
		"\tEOF\n" \
		"\tejson encrypt env/prod.ejson\n" \
		"\tOR for this demo\n" \
		"\tejson ${YELLOW}-keydir env/ejson_keydir${NC} encrypt env/prod.ejson\n" \
		"\t${GREEN}ejson -keydir env/ejson_keydir decrypt env/prod.ejson${NC}\n" \
		"\t{\n" \
		"\t    \"_public_key\": \"7baa89...\",\n" \
		"\t    \"_ejson_visible\": \"EJSON visible key\",\n" \
		"\t    \"ejson_encrpyted\": \"EJSON encrypted key\"\n" \
		"\t}\n" \
		"\t${GREEN}eval \$$(ejson2env ${YELLOW}-keydir env/ejson_keydir${GREEN} env/prod.ejson)${NC}\n" \
		"\t${GREEN}set | ag EJSON${NC}\n\n" \
		"\t\tEJSON_ENCRPYTED='EJSON encrypted key'\n" \
		"\t\t_EJSON_VISIBLE='EJSON visible key'\n"
	@echo

.PHONY: demo
demo: demo-dotenv demo-rails-credentials demo-sops demo-ansible-vault demo-ejson

.PHONY: run
run:
	bin/setup
	bin/rails server

.PHONY: clean
clean:
	@rm .env.local
	@echo "\
	run the following:\n\
	${GREEN}unset EJSON_ENCRPYTED \\\ \n \
		_EJSON_VISIBLE \\\ \n \
		ANSIBLE_VAULT_ENCRYPTED_ENV \\\ \n \
		ANSIBLE_VAULT_VISIBLE_ENV${NC}"

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
	@echo "${YELLOW}make slides${NC}       show slideshow"
	@echo
	@echo "${YELLOW}make demo${NC}         demo all the things"
	@echo "${YELLOW}make demo-dotenv${NC}"
	@echo "${YELLOW}make demo-rails-credentials${NC}"
	@echo "${YELLOW}make demo-sops${NC}"
	@echo "${YELLOW}make demo-ansible-vault${NC}"
	@echo "${YELLOW}make demo-ejson${NC}"
	@echo
	@echo "Development"
	@echo
	@echo "${YELLOW}make run${NC}          run the app"
	@echo
