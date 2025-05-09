require 'icalendar'

class EventsController < ApplicationController
  before_action :find_event, only: [:show, :edit, :update]
  before_action :authorise, except: [:index, :show]

  def index
    @upcoming = Event.upcoming.includes(:location)
    @previous = Event.previous.includes(:location)

    respond_to do |format|
      format.html
      format.ics { render plain: one_year_of_ical }
    end
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


  def one_year_of_ical
    events = Event.where(date: 1.year.ago...).order(date: :desc).includes(:location)
    cal = Icalendar::Calendar.new

    events.each do |event|
      cal.event do |e|
        e.uid         = "nwrug-event-#{event.id}"
        e.location    = "#{event.location.city}, England"
        e.dtstart     = Icalendar::Values::DateTime.new(event.date, tzid: 'Europe/London')
        e.dtend       = Icalendar::Values::DateTime.new((event.date+2.hours), tzid: 'Europe/London')
        e.summary     = "NWRUG: #{event.title}"
        e.description = event.description
      end
    end

    cal.to_ical
  end
end
