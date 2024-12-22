class OauthController < ApplicationController
  # If you're using a strategy that POSTs during callback, you'll need to skip the authenticity token check for the callback action only.
  skip_before_action :verify_authenticity_token, only: :create

  def new
    config = Rails.application.config_for(:"keycloak")
    port_str = [ 80, 443 ].include?(request.port.to_i) ? "" : ":" + request.port.to_s
    redirect_uri = "#{request.scheme}://#{request.host}#{port_str}/oauth/keycloak/callback"
      redirect_uri_escaped = CGI.escape(redirect_uri)
    client_id = config["resource"]
    realm = config["realm"]
    auth_server_url = config["authServerUrl"]
    to = "#{auth_server_url}/realms/#{realm}/protocol/openid-connect/auth?response_type=code&client_id=#{client_id}&redirect_uri=#{redirect_uri_escaped}&login=true&scope=openid"
      redirect_to to, allow_other_host: true
  end

  def create
    current_user = user_for(id: auth_hash.extra.raw_info.sub, email: auth_hash.info.emaim)
    session[:current_user_id] = current_user.id
    redirect_to after_login_path
  end

  def failure
    Rails.logger.warn "bad stuff !"
  end

  def user_for(email:, id:)
    raise "user_for(email:, id:) not defined"
  end

  protected

  def auth_hash
    auth = request.env["omniauth.auth"]
    raise Errors::NotAuthenticatedError unless auth

    auth
  end
  def after_login_path
    graphiql_rails_path
  end

  def user_for(email:, id:)
    command = Accounts::Commands::User::Create.new(id: auth_hash.extra.raw_info.sub, email: auth_hash.info.email)
    handler = Accounts::CommandHandlers::User::Create.handle(command: command, current_user_id: command.id)
    handler.object
  end
end
