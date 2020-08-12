module EventHelper
  def location_text(event)
    if event.online?
      "Online"
    else
      "at #{event.location.name}"
    end
  end
end
