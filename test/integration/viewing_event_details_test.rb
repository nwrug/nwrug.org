require 'test_helper'

class ViewingEventDetailsTest < ActionDispatch::IntegrationTest
  test "displays an event's details" do
    event = events(:next_event)
    visit events_path

    within "ul#upcoming-events" do
      click_on event.title
    end

    assert page.has_content?(event.title)
    assert page.has_content?(event.description)
    assert page.has_content?("at The Manchester Digital Laboratory (MadLab)")
  end

  test "viewing an ICAL feed of events" do
    event = events(:next_event)
    visit(events_path(format: :ics))

    assert page.body.start_with?('BEGIN:VCALENDAR')
    assert page.has_content?("SUMMARY:NWRUG: #{event.title}")
    assert page.has_content?("DESCRIPTION:#{event.description}")
    assert page.has_content?('LOCATION:The Manchester Digital Laboratory (MadLab)\, 36-40 Edge Street')
  end
end
