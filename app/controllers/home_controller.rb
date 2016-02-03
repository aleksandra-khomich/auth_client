class HomeController < ApplicationController
  def index
    @user = User.find_by(uid: session[:current_user])
  end
end
