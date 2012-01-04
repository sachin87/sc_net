class Article < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :category

  validates :title, :presence => true
  validates :synopsis, :presence => true
  validates :body, :presence => true
  validates :title, :presence => true
  validates_length_of :title, :maximum => 255
  validates_length_of :synopsis, :maximum => 1000
  validates_length_of :body, :maximum => 20000

  before_save :update_published_at
  
  def update_published_at
    self.published_at = Time.now if published?
  end

end
