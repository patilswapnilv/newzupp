class Site < ActiveRecord::Base

  # Associations
  has_many :stories

  # Validations
  validate :name, :presence => true
  validate :url, :presence => true
  validate :shortname, :presence => true
  
  # Update all sites, fetch front page stories and update votes for front page stories
  def self.update_front_page
    Site.all.each do |site|
      site.fetch_and_save_stories
    end

  end

  def fetch_and_save_stories
    stories = get_stories
    stories.each do |story|
      record = shortname == "reddit" ? story["data"] : story
      Story.find_or_create_story(id, shortname, record["url"], record["title"], record[score_name])
    end
  end

  def get_stories
    result = JSON.parse(get_http_response(top_stories_endpoint))
    stories = case shortname
              when "digg"       then result["stories"]
              when "reddit"     then result["data"]["children"]
              when "tweetmeme"  then result["stories"]
              when "hn"         then result["items"]
              end
    return stories
  end

  def get_http_response(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    request.initialize_http_header({"User-Agent" => "Newzupp/2.0"})
    response = http.request(request)
    response.body
  end

end
