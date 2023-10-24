# frozen_string_literal: true

class AnsibleVaultDemoConfig < ApplicationConfig
  config_name :ansible_vault_demo

  env_prefix :ansible_vault

  attr_config :encrypted_env
  attr_config :visible_env
end
