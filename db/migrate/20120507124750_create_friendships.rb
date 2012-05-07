class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.column :user_id, :integer, :null => false
      t.column :friend_id, :integer, :null => false

      t.column :friend, :boolean, :default => false, :null => false
      t.column :acquaintance, :boolean, :default => false, :null => false
      t.column :contact, :boolean, :default => false, :null => false

      t.column :met, :boolean, :default => false, :null => false

      t.column :coworker, :boolean, :default => false, :null => false
      t.column :colleague, :boolean, :default => false, :null => false
      
      t.column :coresident, :boolean, :default => false, :null => false
      t.column :neighbor, :boolean, :default => false, :null => false

      t.column :child, :boolean, :default => false, :null => false
      t.column :parent, :boolean, :default => false, :null => false
      t.column :sibling, :boolean, :default => false, :null => false
      t.column :spouse, :boolean, :default => false, :null => false
      t.column :kin, :boolean, :default => false, :null => false
      
      t.column :muse, :boolean, :default => false, :null => false
      t.column :crush, :boolean, :default => false, :null => false
      t.column :date, :boolean, :default => false, :null => false
      t.column :sweetheart, :boolean, :default => false, :null => false
      t.timestamps  
    end
    add_index :friendships, [:user_id, :friend_id]
  end
end

