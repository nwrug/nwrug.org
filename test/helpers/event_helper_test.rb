require 'test_helper'

class EventHelperTest < ActionView::TestCase

  test '#next_event_date returns the third Thursday of the month' do
    travel_to Date.new(2015, 8, 1) do
      assert_equal Date.new(2015, 8, 20), next_event_date
    end
  end

  test "#next_event_date returns today if it's the third Thursday of the month" do
    travel_to Date.new(2015, 8, 20) do
      assert_equal Date.new(2015, 8, 20), next_event_date
    end
  end

  test "#next_event_date returns the third Thursday of next month if this month's has passed" do
    travel_to Date.new(2015, 8, 21) do
      assert_equal Date.new(2015, 9, 17), next_event_date
    end
  end

  test "#next_event_date correctly rolls over at the end of the year" do
    travel_to Date.new(2015, 12, 20) do
      assert_equal Date.new(2016, 1, 21), next_event_date
    end
  end
end
