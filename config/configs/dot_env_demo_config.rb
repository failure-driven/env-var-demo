# frozen_string_literal: true

class DotEnvDemoConfig < ApplicationConfig
  config_name :dot_env_demo

  env_prefix :dot_env

  attr_config :visible
  attr_config :secret
  attr_config :overwritten_visible
  attr_config :overwritten_secret
end
