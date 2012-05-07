class Category < ActiveRecord::Base

  has_many :articles, :dependent => :nullify
  validates :name, :length => { :maximum => 80 }
  
end
