class Geocode < ActiveRecord::Migration[5.0]
  def change
    add_column :contents, :latitude, :float
    add_column :contents, :longitude, :float
  end
end
