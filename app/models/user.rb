class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :authentications
  has_many :articles
  has_many :entries
  has_many :comments
  has_many :photos
  has_many :usertemplates
  has_and_belongs_to_many :roles

  has_many :friendships
  has_many :friends, :through => :friendships, :class_name => 'User'

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  validates :profile, :length => { :maximum => 1000 }
  validates :username, :uniqueness => true

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username

  def email_with_username
    "#{username} <#{email}>"
  end
  
  def apply_omniauth(omniauth)
    self.email = omniauth['user_info']['email'] if email.blank?
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  def has_role?(rolename)
    self.roles.find_by_name(rolename) ? true : false
  end

  def password_required?
    new_record? || !password.blank? || !password_confirmation.blank? ? super : false
  end

  def get_flickr_id
    # build the flickr request
    flickr_request = "http://api.flickr.com/services/rest/?"
    flickr_request += "method=flickr.people.findByUsername"
    flickr_request += "&username=#{self.flickr_username}"
    flickr_request += "&api_key=#{FLICKR_API_KEY}"
    # perform the API call
    response = ""
    open(flickr_request) do |s|
      response = s.read
    end
    # parse the result
    xml_response = REXML::Document.new(response)
    if xml_response.root.attributes["stat"] == 'ok'
      xml_response.root.elements["user"].attributes["nsid"]
    else
      nil
    end
  end

  def flickr_feed
    flickr_request = "http://api.flickr.com/services/feeds/photos_public.gne?"
    flickr_request += "id=#{self.flickr_id}"
    flickr_request += "&format=rss_200_enc"
    rss_content = ""
    open(flickr_request) do |s|
      rss_content = s.read
    end
    return RSS::Parser.parse(rss_content, false)
  end

  def to_liquid
    UserDrop.new(self)
  end

end