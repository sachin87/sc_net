class NewslettersController < InheritedResources::Base
  
  def sendmails
    newsletter = Newsletter.find_by_id_and_sent(params[:id], false)
    users = User.find(:all)
    users.each do |user|
      Notifier.deliver_newsletter(user, newsletter)
    end
    newsletter.update_attribute('sent', true)
    redirect_to newsletters_path
  end

end
