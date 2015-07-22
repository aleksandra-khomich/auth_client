class UsersController < ApplicationController

  def finish_sign_up
    @user = HTTParty.get("http://localhost:3000/me.json?token=#{params[:token]}")
  end

  def update
    result = HTTParty.post("http://localhost:3000/users/update.json",
                           body: {
                               user: {
                                   email: params[:email],
                                   first_name: params[:first_name],
                                   last_name: params[:last_name],
                                   password: params[:password]
                               },
                               token: params[:token]
                           }.to_json,
                           headers: { 'Content-Type' => 'application/json',
                                      'Accept' => 'application/json'} )
    if result.code == 200
      redirect_to root_path, notice: result["message"]
    else
      flash[:errors] = result["errors"]
      redirect_to finish_sign_up_path(token: params[:token], first_name: params[:first_name], last_name: params[:last_name])
    end
  end

  def confirm
    result = HTTParty.post("http://localhost:3000/users/confirm_email?token=#{params[:confirmation_token]}")
    if result.code == 200
      redirect_to root_path, notice: "Your email address has been successfully confirmed."
    end
  end

  def new
  end

  def create
    result = HTTParty.post("http://localhost:3000/users/create.json",
                           body: {
                               user: {
                                   email: params[:email],
                                   first_name: params[:first_name],
                                   last_name: params[:last_name],
                                   password: params[:password]
                               },
                           }.to_json,
                           headers: { 'Content-Type' => 'application/json',
                                      'Accept' => 'application/json'} )
    if result.code == 200
      redirect_to root_path
    elsif result.code == 422
      flash[:errors] = result["errors"]
      redirect_to users_new_path(first_name: params[:first_name], last_name: params[:last_name], email: params[:email])
    end
  end
end
