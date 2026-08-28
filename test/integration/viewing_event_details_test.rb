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

    og_image_url = event_open_graph_image_url(event, format: :png)
    assert page.has_css?(%(meta[property="og:image"][content="#{og_image_url}"]), visible: false)
  end

  test "viewing an ICAL feed of events" do
    event = events(:next_event)
    visit(events_path(format: :ics))

    assert page.body.start_with?('BEGIN:VCALENDAR')
    assert page.has_content?("SUMMARY:NWRUG: #{event.title}")
    assert page.has_content?("DESCRIPTION:#{event.description}")
    assert page.has_content?('LOCATION:The Manchester Digital Laboratory (MadLab)\, 36-40 Edge Street')
    assert page.has_content?('URL;VALUE=URI:http://www.example.com/events/an-event-for-august')
  end

  test 'ICAL feed when there is no future event shows a TBC event with the right date' do
    events(:next_event).destroy!
    visit(events_path(format: :ics))

    tz = TZInfo::Timezone.get 'Europe/London'
    next_event_date = Icalendar::Values::DateTime.new(Event.next_date, tzid: tz.identifier)

    assert page.body.start_with?('BEGIN:VCALENDAR')
    assert page.has_content?("SUMMARY:NWRUG: North West Ruby User Group Meetup")
    assert page.has_content?("DESCRIPTION:Details to follow...")
    assert page.has_content?('LOCATION:Manchester\, UK')

    assert page.has_content?(next_event_date.value_ical)
  end
end
