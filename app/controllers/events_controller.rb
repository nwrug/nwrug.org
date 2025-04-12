class EventsController < ApplicationController
  before_action :find_event, only: [:show, :edit, :update]
  before_action :authorise, except: [:index, :show]

  def index
    @upcoming = Event.upcoming.includes(:location)
    @previous = Event.previous.includes(:location)
  end

  def new
    @event = Event.new_with_defaults
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit
    end
  end

private

  def find_event
    @event = Event.find_by!(slug: params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :date, :slug, :location_id, :online)
  end
end
