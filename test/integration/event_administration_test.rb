require 'test_helper'

class EventAdministrationTest < ActionDispatch::IntegrationTest
  test 'unauthorised user cannot create an event' do
    visit events_path
    refute page.has_link?('new event', href: new_event_path)

    visit new_event_path
    assert_path signin_path
  end

  test 'authorised user can create an event' do
    login_as users(:admin)
    visit events_path
    click_link 'New event'

    fill_in :event_title, with: 'New event title'
    fill_in :event_description, with: 'Event description'
    click_on 'Save'

    last_event = Event.last

    assert_equal 'New event title', last_event.title
  end

  test 'authorised user can create an online event' do
    login_as users(:admin)
    visit events_path
    click_link 'New event'

    fill_in :event_title, with: 'Online event'
    fill_in :event_description, with: 'Somewhere in cyberspace'
    check :event_online
    click_on 'Save'

    last_event = Event.last

    assert_equal 'Online event', last_event.title
    assert last_event.online?
  end

  test 'unauthorised user cannot edit an event' do
    event = events(:august_2015)

    visit event_path(event)
    refute page.has_link?('Edit', href: edit_event_path(event))

    visit edit_event_path(event)
    assert_path signin_path
  end

  test 'authorised user can edit an event' do
    event = events(:august_2015)

    login_as users(:admin)
    visit event_path(event)

    click_link 'Edit'

    assert_path edit_event_path(event)
  end
end
