# Renders Open Graph images for events
module Events
  class OpenGraphImagesController < ApplicationController
    before_action :find_event

    def show
      respond_to do |format|
        format.png { send_data open_graph_image, type: 'image/png', disposition: 'inline' }
      end
    end

    private

    def find_event
      @event = Event.find_by!(slug: params[:event_id])
    end

    def open_graph_image
      Rails.cache.fetch("event/#{@event.id}/#{@event.updated_at.to_i}/open_graph_image") do
        location = @event.online? ? 'Online' : @event.location.name
        OpenGraphImage.new(title: @event.title, subheading: "#{@event.date.to_fs(:short_date)}, #{@event.time} — #{location}").generate
      end
    end
  end
end
