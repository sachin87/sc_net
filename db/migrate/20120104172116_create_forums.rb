class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.column :name, :string
      t.column :description, :text
      t.column :topics_count, :integer, :null => false, :default => 0
      t.timestamps
    end
  end
end
