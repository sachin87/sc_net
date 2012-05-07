class Notifier < ActionMailer::Base
  default from: "Social Networking <system@sc.net>"

  def new_comment_notification(comment)
    blog_owner = comment.entry.user
    mail(:to => "#{blog_owner.email_with_username}", 
         :subject => "A new comment has been left on your blog",
         :comment => comment,
         :blog_owner => blog_owner,
         :blog_owner_url => "http://sc.net/users/#{blog_owner.id}",
         :blog_entry_url => "http://sc.net/users/#{blog_owner.id}/entries/#{comment.entry.id}")
  end

end
