class AddFlickrUserFields < ActiveRecord::Migration
  def up
    add_column :users, :flickr_username, :string
    add_column :users, :flickr_id, :string
  end

  def down
    remove_column :users, :flickr_username
    remove_column :users, :flickr_id
  end
end
