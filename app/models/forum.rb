class Forum < ActiveRecord::Base
  
  has_many :topics, :dependent => :destroy
  has_many :posts, :through => :topics

  validates :name, :presence => true
  validates :name, :length => { :maximum => 255 }
  validates :description, :length => { :maximum => 1000 }
  
end
