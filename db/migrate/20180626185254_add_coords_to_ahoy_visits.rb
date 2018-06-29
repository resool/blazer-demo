class AddCoordsToAhoyVisits < ActiveRecord::Migration[5.2]
  def change
    add_column :ahoy_visits, :lat, :decimal, { precision: 10, scale: 6 }
    add_column :ahoy_visits, :lng, :decimal, { precision: 10, scale: 6 }
  end
end
