class Gesture < ActiveRecord::Base
  validates :title, presence: true
  validates :compressed_data, presence: true
end
