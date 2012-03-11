class AddRolesToUser < ActiveRecord::Migration
  def change
    User.create(:email => 'sachin.y87@gmail.com', :password => '12345678', :password_confirmation => '12345678', :enabled => true)
    ['Administrator', 'Moderator', "Editor"].each do |name|
      Role.create(:name => name)
    end
    admin_user = User.first
    admin_user.roles << Role.all
  end
end
