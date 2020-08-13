class Location < ApplicationRecord
  has_many :events

  validates_format_of :website, :with => /\A#{URI::regexp(%w(http https))}\z/, allow_blank: true
  validates :name, :street_address, :city, :postal_code, presence: true
end
