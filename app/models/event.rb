class Event < ApplicationRecord
  include Slugged

  validates :title, :description, :date, presence: true
  validates :location, presence: true, unless: :online?

  belongs_to :location, optional: true

  scope :upcoming, -> { where("date >= ?", Time.zone.today).order(date: :asc) }
  scope :previous, -> { where("date < ?", Time.zone.today).order(date: :desc) }

  def self.new_with_defaults
    previous_event = Event.order(:date).last
    new(date: next_date, location: previous_event.location, online: previous_event.online?)
  end

  def self.next_date
    if third_thursday_of_month.past?
      third_thursday_of_month(Time.zone.today + 1.month)
    else
      third_thursday_of_month
    end
  end

  def time
    date.strftime('%l:%M%P').strip
  end

private

  def set_slug
    return if date.blank? || slug.present?

    self.slug = (date.strftime('%B %Y ') + title).parameterize
  end

  def self.third_thursday_of_month(base_date=nil)
    base_date ||= Time.zone.today
    year  = base_date.year
    month = base_date.month
    day   = (4 - Date.new(year, month, 1).wday) % 7 + (2*7) + 1

    DateTime.new(year, month, day, 18, 30)
  end
end
