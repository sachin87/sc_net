class Page < ActiveRecord::Base
  
  validates :title, :body , :presence => true
  validates :title, :length => (3..255)
  validates :body, :length => { :maximum => 10000 }

  before_create :set_paramlink

  def to_param
    "#{id}-#{permalink}"
  end

  private

  def set_paramlink
    self.permalink = title.downcase.gsub(/\s+/, '_').gsub(/[^a-zA-Z0-9_]+/, '')
  end

end
