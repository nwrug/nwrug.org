require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "generates a slug from the title and date" do
    event = create_event!(title: "An event!", date: DateTime.new(2015,5,20))

    assert_equal 'may-2015-an-event', event.slug
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

  test "returns the time" do
    event = create_event!(date: DateTime.new(2015, 8, 1, 19, 0))
    assert_equal "7:00pm", event.time
  end

private

  def create_event!(overrides={})
    Event.create!({
      title: "Event title",
      description: 'Event description',
      date: 1.week.from_now }.merge(overrides))
  end
end
