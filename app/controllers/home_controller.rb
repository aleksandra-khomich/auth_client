class HomeController < ApplicationController
  def index
    @user = session[:current_user]
  end
end
