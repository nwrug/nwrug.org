require 'test_helper'

class NextEventDetailsTest < ActionDispatch::IntegrationTest

  test 'includes a link to the next upcoming event' do
    event = events(:august_2015)

    visit root_path

    assert page.has_link? event.title, event_path(event)
  end

  test 'displays the default date (the next third Thursday) if a future event does not exist yet' do
    travel_to Date.new(2015, 8, 21) do
      visit root_path
      assert page.has_content? "Next Event: Thursday 17th September"
    end
  end
end
