class Event < ActiveRecord::Base
  before_validation :set_slug, on: :create
  validates :slug, uniqueness: true
  validates :title, :description, :slug, :date, presence: true

  def to_param
    slug
  end

private

  def set_slug
    self.slug ||= title.parameterize
  end
end
