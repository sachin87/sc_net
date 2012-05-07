class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :authentications
  has_many :articles
  has_many :entries
  has_many :comments
  has_many :photos
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

end