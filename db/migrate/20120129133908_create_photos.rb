class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.column :user_id, :integer
      t.column :title, :string
      t.column :body, :text
      t.timestamps
      # the following columns are required for attachment_fu
      t.column :photo_file_name, :string
      t.column :photo_file_size, :integer
      t.column :photo_content_type, :string
      t.column :photo_updated_at, :datetime
    end
    add_column :users, :photos_count, :integer
  end
  def self.down
    drop_table :photos
    remove_column :users, :photos_count
  end
end
