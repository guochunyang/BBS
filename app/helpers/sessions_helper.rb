module SessionsHelper

  def sign_in(user)
    session[:user_id] = user.id
    self.current_user = user
  end

  def sign_in_remember(user)
    #cookies[:remember_token] =user.remember_token
    cookies[:remember_token] = {
        value:   user.remember_token,
        expires: 2.weeks.from_now
    }
  end


  def sign_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) || User.find_by(remember_token: cookies[:remember_token])
  end


  def sign_out
    self.current_user = nil

    reset_session
    cookies.delete(:remember_token)
  end

end
