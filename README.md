# Env Var demos

1. rails crednetials
1. SOPS
1. Ansible vault
1. .env
1. EJson

## Demo

### Rails Credentials

```sh
TODO: rails credentials demo
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
