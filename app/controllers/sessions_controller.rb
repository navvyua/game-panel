class SessionsController < ApplicationController
  layout 'authentication'

  before_action :unauthenticated_only, only: %i(new create)
  before_action :authenticated_only, only: :destroy

  def create
    auth_params ? oauth_create : default_create
  end

  def destroy
    session[:user_id] = nil
    redirect_to sign_in_path, notice: t('.signed_out')
  end

  private

  def auth_params
    request.env['omniauth.auth']
  end

  def account_params
    { uid: auth_params['uid'], provider: auth_params['provider'] }
  end

  def user_params
    password = SecureRandom.hex(8)
    user = User.find_or_create_by(email: auth_params['info']['email']) do |u|
      u.name = auth_params['info']['name']
      u.password = password
      u.password_confirmation = password
    end
    { user: user }
  end

  def default_create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      valid_authentication(user)
    else
      invalid_authencation
    end
  end

  def valid_authentication(user)
    session[:user_id] = user.id
    redirect_to root_path, notice: t('.signed_in')
  end

  def invalid_authencation
    flash.now[:alert] = t('.incorrect_sign_in')
    render :new
  end

  def oauth_create
    account = Account.find_by(account_params)
    account = Account.create(account_params.merge(user_params)) unless account
    session[:user_id] = account.user_id
    redirect_to root_path, notice: t('.signed_in')
  end
end
