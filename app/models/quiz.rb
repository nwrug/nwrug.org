class Quiz < ActiveRecord::Base
  before_validation :set_slug, on: :create
  validates :slug, uniqueness: true


  def to_param
    slug
  end

private

  def set_slug
    return if slug.present?

    self.slug = title.parameterize
  end
end
