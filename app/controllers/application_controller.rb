class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

private

  def next_event
    @next_event ||= Event.where("date >= ?", Date.today).order(date: :asc).first
  end
  helper_method :next_event

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorise
    unless current_user.present?
      flash[:intended_path] = request.fullpath
      redirect_to signin_url
    end
  end
end
