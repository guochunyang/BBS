class SessionsController < ApplicationController
  include SessionsHelper

  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      #session[:user_id] = user.id
      redirect_to user
    else
      flash.now[:error] = "用户名或者密码错误"
      flash.keep
      redirect_to signin_path
    end

  end

  def destroy

  end

end
