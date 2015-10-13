require 'test_helper'

class QuizTest < ActiveSupport::TestCase
  test "generates a slug from the title" do
    event = create_quiz!(title: "A Quiz!")

    assert_equal 'a-quiz', event.slug
  end

  test "ignores blank slug strings" do
    event = Quiz.new(title: 'some title', slug: '')
    event.valid?

    assert_equal 'some-title', event.slug
  end

  test "ensures the slug is unique" do
    event = create_quiz!(title: 'A title')
    clash = Quiz.new(title: event.title)

    refute clash.valid?
    assert_match /already been taken/, clash.errors[:slug].first
  end

  test "does not overwrite an existing slug" do
    event = create_quiz!(title: 'Some title', slug: 'another-slug')

    assert_equal 'another-slug', event.slug
  end

private

  def create_quiz!(overrides={})
    Quiz.create!({
      title: "Code Quiz",
      description: 'Quiz description',
    }.merge(overrides))
  end
end
