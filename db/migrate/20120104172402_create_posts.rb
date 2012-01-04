class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.column :topic_id, :integer
      t.column :user_id, :integer
      t.column :body, :text
      t.timestamps
    end
    add_index :posts, :topic_id
  end
end
