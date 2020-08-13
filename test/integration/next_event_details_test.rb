require 'test_helper'

class NextEventDetailsTest < ActionDispatch::IntegrationTest

  test 'homepage includes a link to the next upcoming event' do
    event = events(:august_2015)

    visit root_path

    assert page.has_link?(event.title, href: event_path(event))
  end

  test 'homepage displays the default date (the next third Thursday) if no future event exist yet' do
    travel_to Date.new(2015, 8, 21) do
      visit root_path
      assert page.has_content? "Next Event: Thursday 17th September"
    end
  end

  test 'participate page displays the default date' do
    travel_to Date.new(2015, 8, 21) do
      visit participate_path
      assert page.has_content? "The next event will be on Thursday 17th September"
    end
  end
end
