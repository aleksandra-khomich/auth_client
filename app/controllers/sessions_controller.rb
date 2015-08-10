class SessionsController < ApplicationController
  def create
    session[:current_user] = auth_hash['token']
    redirect_to root_path
  end

  def destroy
    session[:user_token] = nil
    session[:current_user] = nil
    redirect_to root_path
  end

  def destroy_access_token
    cookies.delete "_auth_service_session"
    session[:user_token] = nil
    session[:current_user] = nil
    redirect_to root_path
  end

  protected

  def auth_hash
    auth = request.env['omniauth.auth']
    auth.present? ? auth['extra']['raw_info'] : SendRequest.perform(method: 'get', path: 'me.json', query: "token=#{params[:token]}")
  end
end
