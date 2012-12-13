class SessionsController < ApplicationController
  def new
    session[:redirect_page] = request.env['HTTP_REFERER'].nil? ? :root : request.env['HTTP_REFERER']
  end

  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to session[:redirect_page], notice: "Welcome back #{user.name}"
    else
      redirect_to login_path, alert: "Oops! There was an error, please check your email address and password"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:redirect_page] = request.env['HTTP_REFERER'].nil? ? :root : request.env['HTTP_REFERER']
    redirect_to session[:redirect_page]
  end
end
