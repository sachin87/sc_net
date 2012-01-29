class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.column :name, :string
      t.timestamps
    end
  end
end
