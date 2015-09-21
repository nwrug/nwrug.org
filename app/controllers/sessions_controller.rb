class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to events_url, notice: 'Signed in.'
    else
      redirect_to signin_url, alert: 'Incorrect email or password.'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
