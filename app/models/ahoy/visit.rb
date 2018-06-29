class Ahoy::Visit < ApplicationRecord
  self.table_name = 'ahoy_visits'

  before_create :set_coords

  belongs_to :user, optional: true
  has_many :events, class_name: 'Ahoy::Event'

  private

  def set_coords
    self.lat, self.lng = Geocoder.search(ip)
  end
end
