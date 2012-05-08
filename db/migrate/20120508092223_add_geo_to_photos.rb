class AddGeoToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :geo_lat, :float
    add_column :photos, :geo_long, :float
    add_column :photos, :show_geo, :boolean, :default => true, :null => false
  end
end
