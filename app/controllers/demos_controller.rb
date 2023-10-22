class DemosController < ApplicationController
  def index
    @env_vars = {}
    %w[
      EJSON_ENCRPYTED
      _EJSON_VISIBLE
      ANSIBLE_VAULT_ENCRYPTED_ENV
      ANSIBLE_VAULT_VISIBLE_ENV
      DOT_ENV_VISIBLE
      DOT_ENV_SECRET
      DOT_ENV_OVERWRITTEN_VISIBLE
      DOT_ENV_OVERWRITTEN_SECRET
    ].each do |env_var_key|
      @env_vars[env_var_key] = ENV.fetch(env_var_key, nil)
    end
  end

  def read_file
    respond_to do |format|
      format.html do
        content = File
          .read(Rails.root.join(params[:filename]))
          .split("\n")
          .map{ |line| "<code>#{line}</code><br />" }
        render :inline => content.join("\n").html_safe
      end
    end
  end
end
