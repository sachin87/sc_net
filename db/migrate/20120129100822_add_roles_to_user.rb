class AddRolesToUser < ActiveRecord::Migration
  def change
    ['Administrator', 'Moderator', "Editor"].each do |name|
      Role.create(:name => name)
    end
    admin_user = User.first
    admin_user.roles << Role.all
  end
end
