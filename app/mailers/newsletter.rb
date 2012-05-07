class Newsletter < ActionMailer::Base
  default from: "from@example.com"

  def newsletter(user, newsletter)
    mail(:to => "#{user.email_with_username}",
         :subject => newsletter.subject,
         :body => newsletter.body,
         :user => user)
  end
  
end