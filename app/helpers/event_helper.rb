module EventHelper

  def location_string location
    if location.present?
      "at #{location.name}"
    else
      "(location TBC)"
    end
  end
end
