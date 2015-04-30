class Gesture < ActiveRecord::Base
  validates :title, presence: true
  validates :compressed_data, presence: true

  def self.search(search)
    if search
      where('title LIKE ?', search.to_s + '%')
    else
      scoped
    end
  end
end
