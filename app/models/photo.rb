class Photo < ActiveRecord::Base

  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates_attachment_presence :photo

  acts_as_taggable
  
  belongs_to :user

  after_save :update_last_activity_of_user

  def update_last_activity_of_user
    if self.user
      self.user.update_attribute(:last_activity, "Uploaded a photo")
      self.user.update_attribute(:last_activity_at, Time.now)
    end
  end

end
