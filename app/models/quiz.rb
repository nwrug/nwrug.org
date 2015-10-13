class Quiz < ActiveRecord::Base
  include Slugged

  validates :title, :description, presence: true
end
