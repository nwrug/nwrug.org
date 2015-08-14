class EventsController < ApplicationController
  def show
    @event = Event.find_by!(slug: params[:id])
  end
end
