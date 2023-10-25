# Env Var demos

1. rails crednetials
1. SOPS
1. Ansible vault
1. .env
1. EJson

## Presentation

```
make
make install
make slides
```

## Demo

### Env Vars

what is the problem?
- 12 factor app - https://12factor.net/
- unencrypted at rest

### Dot Env

```sh
bundle add dotenv-rails
```

a hierarcy of .env* files as described in
https://github.com/bkeepers/dotenv#what-other-env-files-can-i-use

| Hierarchy Priority | Filename                 | Environment          | Should I `.gitignore`it? | Notes                                                        |
| ------------------ | ------------------------ | -------------------- | ------------------------ | ------------------------------------------------------------ |
| 1st (highest)      | `.env.development.local` | Development          | Yes!                     | Local overrides of environment-specific settings.            |
| 1st                | `.env.test.local`        | Test                 | Yes!                     | Local overrides of environment-specific settings.            |
| 1st                | `.env.production.local`  | Production           | Yes!                     | Local overrides of environment-specific settings.            |
| 2nd                | `.env.local`             | Wherever the file is | Definitely.              | Local overrides. This file is loaded for all environments _except_ `test`. |
| 3rd                | `.env.development`       | Development          | No.                      | Shared environment-specific settings                         |
| 3rd                | `.env.test`              | Test                 | No.                      | Shared environment-specific settings                         |
| 3rd                | `.env.production`        | Production           | No.                      | Shared environment-specific settings                         |
| Last               | `.env`                   | All Environments     | Depends                  | The Original®                                                |

```sh
make demo-dotenv
make .env.local
```

### Rails Credentials

no key

```sh
cat config/master.key
```

```sh
make demo-rails-credentials

# and now a key via 1password
cat config/master.key
```

### SOPS

```sh
TODO: SOPS demo
```

### Ansible vault

```sh
make demo-ansible-vault
# Ansible vault demo, run:
bin/secrets-init prod
bin/secrets-edit prod

# password is: password

source bin/secrets-load prod

set | ag ANSIBLE
  ANSIBLE_VAULT_ENCRYPTED_ENV=the-ansbile-encrypted-env
  ANSIBLE_VAULT_VISIBLE_ENV=the-ansible-visible-env
```

### EJSON

```sh
make demo-ejson
# place the keys somewhere like /opt/ejson/keys
mkdir -p env/ejson_keydir
ejson -keydir env/ejson_keydir keygen -w
  7baa8909...

cat <<EOF > env/prod.ejson
{
    "_public_key": "7baa89...",
    "environment": {
        "_EJSON_VISIBLE": "EJSON visible key",
        "EJSON_ENCRPYTED": "EJSON encrypted key"
    }
}
EOF

ejson encrypt env/prod.ejson
# OR for this demo
ejson -keydir env/ejson_keydir encrypt env/prod.ejson
ejson -keydir env/ejson_keydir decrypt env/prod.ejson
  {
    "_public_key": "7baa89...",
    "_ejson_visible": "EJSON visible key",
    "ejson_encrpyted": "EJSON encrypted key"
  }

eval $(ejson2env -keydir env/ejson_keydir env/prod.ejson)
set | ag EJSON

  EJSON_ENCRPYTED='EJSON encrypted key'
  _EJSON_VISIBLE='EJSON visible key'
```

### 1Password bootstrapping

you can bootstrap your app with a fetch from 1Password with something along the
lines of:

```sh
brew install op     # https://developer.1password.com/docs/cli
op vault list | grep --quiet YourOrganisation && \
    echo "signed in to ${GREEN}1password!${NC}" || \
    { echo "need to be signed into ${YELLOW}1password${NC} with \
    ${RED}eval \$$(op signin)${NC}"; exit
    op read op://YourOrganisation/your-secret/notes \
    > ./.env.local
    # OR config/master.key
    # OR env/ejson_keydir/<KEY_ID>
```

Other 1password, `op` commands

```
# take a look at your 1password config
cat ~/.config/op/config
{
	"latest_signin": "organisation_name",
	"device": "0123456789abcdefghijklmnop",
	"accounts": [
		{
			"shorthand": "organisation_name",
			"accountUUID": "0123456789ABCDEFGHIJKLMNOP",
			"url": "https://organisation_name.1password.com",
			"email": "michael.milewski@organisation.name.com",
			"accountKey": "AB-CDEFGH-IJKLMN-OPQRS-TUVWX-YZ012-34567",
			"userUUID": "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
		}
	]
}

# list accounts
op accounts list
SHORTHAND   org_name
URL         https://org_name.1password.com
EMAIL       michael.milewski@org.com.au
USER ID     ABCDEFGHIJKLMNOPQRSTUVWXYZ

# add account
op accounts add
Enter your sign-in address (example.1password.com): ^C

# signin and signout
op signin
op signout
```

### Managing Env Vars in ruby with AnywayConfig

AnywayConfig GEM
- as per https://evilmartians.com/chronicles/anyway-config-keep-your-ruby-configuration-sane
- using https://github.com/palkan/anyway_config

```sh
bin/rails r 'puts AnsibleVaultDemoConfig.new.to_h.to_json' | jq

    {
      "visible_env": "the-ansible-visible-env",
      "encrypted_env": "the-ansbile-encrypted-env"
    }

ANSIBLE_VAULT_VISIBLE_ENV="THE OVERRIDE" \
    bin/rails r 'puts AnsibleVaultDemoConfig.new.to_h.to_json' | jq

    {
      "visible_env": "THE OVERRIDE",
      "encrypted_env": "the-ansbile-encrypted-env"
    }
```

### Deploying Kubernetes with injected Env Vars

TODO: using
- based on https://thenewstack.io/managing-kubernetes-secrets-with-aws-secrets-manager/
- using https://github.com/external-secrets/external-secrets
- https://kubernetes.io/docs/tasks/inject-data-application/environment-variable-expose-pod-information/
- vs on file disk with https://docs.aws.amazon.com/secretsmanager/latest/userguide/integrating_csi_driver.html

## Original Rails README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
