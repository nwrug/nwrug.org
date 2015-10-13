module Slugged
  extend ActiveSupport::Concern

  included do
    before_validation :set_slug, on: :create
    validates :slug, uniqueness: true, presence: true
  end

  def to_param
    slug
  end

private

  def set_slug
    return if slug.present?

    self.slug = title.parameterize
  end
end
