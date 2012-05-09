ActiveAdmin.register Page do

  filter :title

  form do |f|
    f.inputs 'Page Details' do
      f.input :title
      f.input :body, :input_html => {:class => :ckeditor}
    end
    f.buttons
  end

  index do
    column :id
    column :title
    column :permalink
    default_actions
  end

end