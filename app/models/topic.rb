class Topic < ActiveRecord::Base
  belongs_to :forum, :counter_cache => true
  belongs_to :user
  has_many :posts, :dependent => :destroy

  validates :name, :presence => true
  validates :name, :length => {:maximum => 255}
end
