require 'test_helper'

class NextEventDetailsTest < ActionDispatch::IntegrationTest

  test 'displays the default date of the next event (every third Thursday)' do
    travel_to Date.new(2015, 8, 1) do
      visit root_path
      assert page.has_content? "Next Event: Thursday 20th August"
    end

    travel_to Date.new(2015, 8, 21) do
      visit root_path
      assert page.has_content? "Next Event: Thursday 17th September"
    end
  end
end
