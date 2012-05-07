class Post < ActiveRecord::Base
  
  belongs_to :topic, :counter_cache => true
  belongs_to :user, :counter_cache => true

  validates :body, :presence => true
  validates:body, :length => { :maximum => 10000 }

  after_save :update_last_activity_of_user

  private

  def update_last_activity_of_user
    self.user.update_attribute(:last_activity, "Posted in the forum")
    self.user.update_attribute(:last_activity_at, Time.now)
  end
  
end