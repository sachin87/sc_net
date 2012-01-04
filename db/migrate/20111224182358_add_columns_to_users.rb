class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ebabled, :boolean
    add_column :users, :profile, :text
  end
end
