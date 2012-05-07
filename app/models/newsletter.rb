class Newsletter < ActiveRecord::Base

  validates :subject, :body, :presence => true
  validates :subject, :length => { :maximum => 255 }
  validates :body, :length => { :maximum => 10000 }

end
