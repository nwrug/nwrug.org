require 'test_helper'

class ViewingEventDetailsTest < ActionDispatch::IntegrationTest
  test "displays an event's details" do
    event = events(:august_2015)
    visit events_path

    within "ul#upcoming-events" do
      click_on event.title
    end

    assert page.has_content?(event.title)
    assert page.has_content?(event.description)
    assert page.has_content?("at The Manchester Digital Laboratory (MadLab)")
  end
end
