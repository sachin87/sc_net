class CreateUsertemplates < ActiveRecord::Migration
  def change
    create_table :usertemplates do |t|
      t.integer :user_id
      t.string :name
      t.text :body
      t.timestamps
    end
    add_index :usertemplates, [:user_id, :name]
  end
end
