class Usertemplate < ActiveRecord::Base
  belongs_to :user
  validates :body, :length => {:maximum => 10000}
end
