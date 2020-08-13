class Quiz < ApplicationRecord
  include Slugged

  validates :title, :description, presence: true
end
