class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|
      t.string :subject
      t.text :body
      t.boolean :sent, :null => false, :default => false
      t.timestamps
    end
  end
end
