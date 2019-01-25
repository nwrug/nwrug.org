require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "generates a slug from the title and date" do
    event = create_event!(title: "An event!", date: DateTime.new(2015,5,20))

    assert_equal 'may-2015-an-event', event.slug
  end

  test "ignores blank slug strings" do
    event = Event.new(title: 'some title', slug: '', date: DateTime.new(2015,6,20))
    event.valid?

    assert_equal 'june-2015-some-title', event.slug
  end

  test "ensures the slug is unique" do
    event = create_event!(title: 'A title')
    clash = Event.new(title: event.title, date: event.date)

    refute clash.valid?
    assert_match /already been taken/, clash.errors[:slug].first
  end

  test "does not overwrite an existing slug" do
    event = create_event!(title: 'Some title', slug: 'another-slug')

    assert_equal 'another-slug', event.slug
  end

  test "#time returns the time" do
    event = create_event!(date: DateTime.new(2015, 8, 1, 19, 0))
    assert_equal "7:00pm", event.time
  end

  test "Event.new_with_defaults sets the date to the next probable date (third Thursday, 7pm)" do
    travel_to Date.new(2015, 8, 21) do
      event = Event.new_with_defaults

      assert_equal DateTime.new(2015, 9, 17, 18, 30), event.date
    end
  end

  test "Event.new_with_defaults sets the location to that of the previous event" do
    _old_event = create_event!(date: Date.new(2015, 1), location: locations(:madlab))
    last_event = create_event!(date: Date.new(2018, 1), location: locations(:otb))

    new_event = Event.new_with_defaults
    assert_equal last_event.location, new_event.location
  end

  test 'Event.next_date returns the third Thursday of the month at 6:30pm' do
    travel_to Date.new(2015, 8, 1) do
      assert_equal DateTime.new(2015, 8, 20, 18, 30), Event.next_date
    end
  end

  test "Event.next_date returns today if it's the third Thursday of the month" do
    travel_to Date.new(2015, 8, 20) do
      assert_equal DateTime.new(2015, 8, 20, 18, 30), Event.next_date
    end
  end

  test "Event.next_date returns the third Thursday of next month if this month's has passed" do
    travel_to Date.new(2015, 8, 21) do
      assert_equal DateTime.new(2015, 9, 17, 18, 30), Event.next_date
    end
  end

  test "Event.next_date correctly rolls over at the end of the year" do
    travel_to Date.new(2015, 12, 20) do
      assert_equal DateTime.new(2016, 1, 21, 18, 30), Event.next_date
    end
  end


private

  def create_event!(overrides={})
    Event.create!(
      {
        title: "Event title",
        description: 'Event description',
        date: 1.week.from_now,
        location: locations(:madlab)
      }.merge(overrides)
    )
  end
end
