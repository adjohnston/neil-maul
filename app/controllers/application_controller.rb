class ApplicationController < ActionController::Base
  protect_from_forgery

  private 

  def authenticate
    if !auth_user
      redirect_to login_path, alert: 'To see this page, you need to be logged in'
    end
  end

  def auth_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :authenticate, :auth_user
end
