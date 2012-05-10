xml.instruct!
xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
  xml.channel do
    xml.title
    xml.link
    xml.pubDate
    xml.description
    "News Feed "
    articles_url
    CGI.rfc1123_date @articles.first.published_at if @articles.any?
    "News about the Us"
    @articles.each do |article|
      xml.item do
        xml.title
        article.title
        xml.link
        article_url(article)
        xml.description article.body
        xml.pubDate
        CGI.rfc1123_date article.published_at
        xml.guid
        article_url(article)
        xml.author
        "#{article.user.email_with_username})"
      end
    end
  end
end
