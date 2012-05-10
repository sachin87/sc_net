class Topic < ActiveRecord::Base
  belongs_to :forum, :counter_cache => true
  belongs_to :user
  has_many :posts, :dependent => :destroy

  validates :name, :presence => true
  validates :name, :length => {:maximum => 255}

  scope :recents_first, lambda{ order('topics.published_at DESC') }
  
end
