module SessionsHelper

  def sign_in(user)
    session[:user_id] = user.id
    self.current_user = user
  end


  def sign_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end


  def sign_out
    current_user = nil
    session[:user_id] = nil
  end

end
