class Entry < ActiveRecord::Base

  belongs_to :user, :counter_cache => true

  has_many :comments
  
  validates :title, :length => { :maximum => 255}
  validates :body, :length => { :maximum => 10000 }
  validates :user_id, :presence => true
  
end