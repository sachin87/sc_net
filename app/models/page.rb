class Page < ActiveRecord::Base
  validates :title, :body , :presence => true
  validates :title, :length => (3..255)
  validates :body, :length => { :maximum => 10000 }

  def before_create
    @attributes['permalink'] = title.downcase.gsub(/\s+/, '_').gsub(/[^a-zA-Z0-9_]+/, '')
  end

  def to_param
    "#{id}-#{permalink}"
  end

end
