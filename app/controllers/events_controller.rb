class EventsController < ApplicationController
  before_filter :find_event, only: [:show, :edit, :update]

  def index
    @events = Event.order(date: :desc)
  end

  def show
    @event = Event.find_by!(slug: params[:id])
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
    if @event.update_attributes(event_params)
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
    params.require(:event).permit(:title, :description, :date, :slug, :location_id)
  end
end
