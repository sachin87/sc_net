class CreateEntries < ActiveRecord::Migration
  def self.down
    create_table :entries do |t|
      t.column :user_id, :integer
      t.column :title, :string
      t.column :body, :text
      t.column :comments_count, :integer, :null => false, :default => 0
      t.timestamps
      add_index :entries, :user_id
    end
  end
  
  def self.down
    drop_table :entries
  end
end
