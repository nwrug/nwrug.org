require 'test_helper'

class EventHelperTest < ActionView::TestCase
  test "#location_text returns the location name prefixed with “at” when the event has a location" do
    the_forum = Location.new(name: "The Forum")
    assert_equal "at The Forum", location_text(Event.new(location: the_forum))
  end

  test "#location_text returns “Online” if the event is online" do
    assert_equal "Online", location_text(Event.new(online: true))
  end
end
