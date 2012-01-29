module EntriesHelper
  def blog_title(user)
    user.blog_title ||= user.email
  end
end