# Thoughts on Environment Variables

- RORO issue
    - https://github.com/rubyaustralia/melbourne-ruby/issues/219
- code
    - https://github.com/failure-driven/env-var-demo
- Michael Milewski
    - @saramic 𝕏
    - http://failure-driven.com

---

# You have a rails app

```sh
rails new 🎉
```

---

# Life is good 🌴

💎   ⛏️ 

🛤️

---

# You have some magic values

```ruby
# TODO code sample
```

---

# You move them out into CONSTANTS

```ruby
# TODO code sample
```

---

# Life is good 🌴

---

# The values are different in environments

```ruby
# TODO code sample
```

---

# You configure them in dev, test and prod

```ruby
# TODO code sample
```

---

# Life is good 🌴

---

# You have a second production???

* **pre-production**
* **user-acceptance-testing**
* **staging**
* **release**
* **sandbox**
* **heroku-deploy-production-disaster-recovery**

---

# You duplicate your environment/production.rb

```sh
tree config/environments
config/environments
├── development.rb
├── test.rb
├── production.rb
├── staging.rb
├── release.rb
└── uat.rb
```

---

# Don't Do That 🚨

> development, test and production should be your **only** modes

```sh
tree config/environments
config/environments
├── development.rb
├── test.rb
├── production.rb
├── ❌staging.rb
├── ❌release.rb
└── ❌uat.rb
```

---

_you haven't seen this presentation so ..._

---

_you haven't seen this presentation so ..._

# Life is good 🌴

---

# You have some secrets 🔐

* **AWS SECRET** for S3
* **DB PASSWORD** for reporting DB
* **API URL** for 3rd party: email, banking, SMS, fraud detection
* **API KEY** for API above

---

# You have some secrets 🔐

so you follow the **process**

```sh
tree config/environments
config/environments
├── development.rb  [`API KEYs and SECRETs`]
├── test.rb
├── production.rb   [`API KEYs and SECRETs`]
├── staging.rb      [`API KEYs and SECRETs`]
├── release.rb      [`API KEYs and SECRETs`]
└── uat.rb          [`API KEYs and SECRETs`]
```

---

# You commit to Git

---

# You commit to Git

you committed **secrets** to GIT 🤦

---

_you haven't seen this presentation so ..._

---

_you haven't seen this presentation so ..._

# It's a privae repo ¯\_(ツ)_/¯

# Life is good 🌴

---

# Don't Do That 🚨

> don't create **processes** that can lead to developers committing secrets to
> GIT

---

# You read about 12 factor Apps
- https://12factor.net/
  > III. Config
  > Store config in the environment

---

# You read Section III Config ...

> An app’s config is everything that is likely to vary between deploys
> (staging, production, developer environments, etc)
> Apps sometimes store config as **constants in the code**. This is a
> **violation of twelve-factor**, which requires strict separation of config
> from code.

- https://12factor.net/config

---

# ... you rewrite your config/environments ...

```sh
tree config/environments
config/environments
├── development.rb
├── test.rb
└── production.rb
```

---

# ... to use Env Vars ...

```ruby
# config/environments/production.rb
Rails.application.config.api_secret = ENV.fetch('API_SECRET')

# config/application.rb
Rails.application.config.api_secret = ENV.fetch('API_SECRET')
```

```ruby
# application code
request.headers['API-Key'] = Rails.application.config.api_secret
```

---

# ... hence removing any secrets

---

# ... hence removing any secrets
# ... and duplication of config/envrionments/production.rb
# solving world peace ☮️  and hunger 🍜

---

# No You Don't 🚨

---

# Quick recap

- **settings** are internal
    - framework settings: puma, sidekiq
    - application settings: EMAIL_ENABLED, default locale
- **secrets** are external
    - redis, database, api, S3
- **ENVIRONMENT** (_demo_)

---

# DevOps moves production secrets to Env Vars

tree config/environments
```sh
config/environments
├── development.rb
├── test.rb
├── production.rb       [ENV VARS]
├── staging.rb          [ENV VARS]
├── release.rb          [ENV VARS]
└── uat.rb              [ENV VARS]
config/application.rb   [ENV VARS]
```

---

# No secrets in GIT 🎉

```sh
config/environments
├── development.rb
├── test.rb
├── production.rb       [ENV VARS]
├── staging.rb          [ENV VARS]
├── release.rb          [ENV VARS]
└── uat.rb              [ENV VARS]
config/application.rb   [ENV VARS]
```

---

# but you can't run the app 😭

```sh
bin/rails s

key not found: "API_SECRET" (KeyError)
```

---

# so you install dotenv GEM

```sh
bundle add dotenv-rails

cat .env.development

API_SECRET='the-real-secret-🔐'
```

---

# and commit that instead 🤦

> again your **process** has allowed you to commit secrets to GIT

---

# so what are the alternatives?

* encrypted secrets

---

# Encrypted Secrets

* rails credentails
* Shopify's EJson
* Mozilla's SOPS
* Ansible Vault

(_demo_)

---

# Decrypting Secrets

* key on disk
* shared environment via tmux (1 reson to have iterm2)

(_demo_)

---

# Managing Secrets

* AnywayConfig

(_demo_)

---

# Why should you care?

- Deployed secrets via Kubernetes
- Production access

---

# Summary

- learn how things work
- be willing to question things
- don't store unencrypted secrets on disk
- working demo at
![QR to code](images/env-var-qr.png)
also mentioned
- rails credentials
- SOPS
- EJson
- Ansible vault
- AnywayConfig
- 12 factor

