class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.column :user_id, :integer
      t.column :title, :string
      t.column :synopsis, :text
      t.column :body, :text
      t.column :published, :boolean, :default => false
      t.column :published_at, :datetime
      t.column :category_id, :integer
      t.timestamps
    end
  end
end
