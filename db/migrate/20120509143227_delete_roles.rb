class DeleteRoles < ActiveRecord::Migration
  def up
    drop_table :roles
    drop_table :roles_users
  end

  def down
    create_table :roles do |t|
      t.column :name, :string
      t.timestamps
    end

    create_table :roles_users, :id => false do |t|
      t.column :role_id, :integer, :null => false
      t.column :user_id, :integer, :null => false
    end
  end
end
