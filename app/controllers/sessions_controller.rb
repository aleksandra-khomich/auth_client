class SessionsController < ApplicationController
  def create
    session[:user_token] = auth_hash['token']
    session[:current_user] = auth_hash['id']
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
    auth.present? ? auth['extra']['raw_info'] : HTTParty.get("http://localhost:3000/me.json?token=#{params[:token]}")
  end
end
