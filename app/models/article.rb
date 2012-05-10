class Article < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :category

  validates :title, :presence => true
  validates :synopsis, :presence => true
  validates :body, :presence => true
  validates :title, :presence => true
  validates :title, :length => { :maximum => 255 }
  validates :synopsis, :length => { :maximum => 1000 }
  validates :body, :length => { :maximum => 20000 }

  scope :published, lambda{ where(:published => true) }
  scope :recents_first, lambda{ order('articles.published_at DESC') }
  scope :in_category, lambda{ |category| where('articles.category_id = ?',category) }

  before_save :update_published_at

  private

  def update_published_at
    self.published_at = Time.now if published?
  end

end
