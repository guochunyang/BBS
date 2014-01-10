class SessionsController < ApplicationController
  include SessionsHelper

  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      sign_in user
      sign_in_remember user if params[:session][:remember_me] == '1'

      redirect_to user
    else
      flash.now[:error] = "用户名或者密码错误"
      flash.keep
      redirect_to signin_path
    end

  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
