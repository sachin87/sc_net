ActiveAdmin.register User do

  filter :email
  filter :username
  filter :blog_title

  index do
    column :username
    column :email
    column :blog_title
    column :last_sign_in_at
    column :created_at
    default_actions
  end

  show :title => :email do
    panel 'User Details' do
      attributes_table_for user, :email,
                                 :username,
                                 :enabled,
                                 :blog_title,
                                 :profile,
                                 :enable_comments,
                                 :admin,
                                 :last_sign_in_at,
                                 :last_sign_in_ip,
                                 :created_at,
                                 :sign_in_count
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'Details' do
      f.input :email
      f.input :username
      f.input :password
      f.input :password_confirmation
      f.input :enabled
      f.input :profile
      f.input :blog_title
      f.input :enable_comments
      f.input :admin
    end
   f.buttons
  end

end