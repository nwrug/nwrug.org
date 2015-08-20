class Event < ActiveRecord::Base
  before_validation :set_slug, on: :create
  validates :slug, uniqueness: true
  validates :title, :description, :slug, :date, presence: true

  belongs_to :location

  def self.new_with_defaults
    new(date: next_date)
  end

  def self.next_date
    if third_thursday_of_month.past?
      third_thursday_of_month(Date.today + 1.month)
    else
      third_thursday_of_month
    end
  end

  def to_param
    slug
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
    base_date ||= Date.today
    year  = base_date.year
    month = base_date.month
    day   = (4 - Date.new(year, month, 1).wday) % 7 + (2*7) + 1

    DateTime.new(year, month, day, 18, 30)
  end
end
