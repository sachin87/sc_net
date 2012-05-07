class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :from
      t.string :to
      t.integer :last_send_attempt, :default => 0
      t.text :mail
      t.timestamps
    end
  end
end
