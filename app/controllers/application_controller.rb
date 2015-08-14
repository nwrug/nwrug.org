class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

private

  def next_event
    @next_event ||= Event.find_by("date >= ?", Date.today)
  end
  helper_method :next_event
end
