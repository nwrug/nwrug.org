class SessionsController < ApplicationController
  def new
    flash.keep(:intended_path)
  end

  def create
    flash.keep(:intended_path)
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to intended_or_default_path, notice: 'Signed in.'
    else
      redirect_to signin_url, alert: 'Incorrect email or password.'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

private

  def intended_or_default_path
    flash[:intended_path] || events_path
  end
end
