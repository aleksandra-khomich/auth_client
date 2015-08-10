class UsersController < ApplicationController

  def finish_sign_up
    @user = User.new
  end

  def update
    result = SendRequest.perform(method: 'post', path: 'users/update.json', query: "token=#{params[:user][:uid]}", post_params: post_params)
    if result.code == 200
      redirect_to root_path, notice: result["message"]
    else
      flash[:errors] = result["errors"]
      redirect_to :back
    end
  end

  def confirm
    result = SendRequest.perform(method: 'post', path: 'users/confirm_email', query: "token=#{params[:confirmation_token]}")
    if result.code == 200
      redirect_to root_path, notice: "Your email address has been successfully confirmed."
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.where(uid: params[:id]).first
  end

  def create
    result = SendRequest.perform(method: 'post', path: 'users/create.json', post_params: post_params)
    if result.code == 200
      redirect_to root_path
    else
      flash[:errors] = result["errors"]
      redirect_to users_new_path(first_name: params[:first_name], last_name: params[:last_name], email: params[:email])
    end
  end

  def post_params
    {
        body: {
            user: params[:user],
            token: params[:token]
        }.to_json,
        headers: {
            'Content-Type' => 'application/json',
            'Accept' => 'application/json'
        }
    }
  end
end
