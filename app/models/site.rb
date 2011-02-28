class Site < ActiveRecord::Base

  include UrlHelper

  # Associations
  has_many :stories

  # Validations
  validate :name, :presence => true
  validate :url, :presence => true
  validate :shortname, :presence => true

  # Update all sites, fetch front page stories and update votes for front page stories
  def self.update_front_page
    # Fetch stories from sites
    start_time = Time.now
    front_page_stories = []
    Site.all.each do |site|
      # Fetch stories from sites
      site.fetch_and_save_stories
      # Update votes from other sites
      site.update_from_other_sites
      # Store 5 newest stories
      front_page_stories << Story.where("updated_at > ? AND site_name = ? AND total_count != ?", start_time, site.shortname, 0).order("updated_at ASC").limit(5).all
      tweetmeme = Site.where(:shortname => "tweetmeme").first
      site.update_from_tweetmeme(front_page_stories) if tweetmeme.api_status
      site.touch
    end
    front_page_stories = front_page_stories.flatten.sort{|a,b| a.total_count <=> b.total_count}
    create_front_page(front_page_stories) unless front_page_stories.blank?
    expire_cached_pages
  end

  def fetch_and_save_stories
    new_stories = get_stories
    if new_stories.blank?
      logger.error "Unable to fetch stories for site - #{name}"
      update_attribute("api_status", false)
    else
      new_stories.each do |story|
        record = shortname == "reddit" ? story["data"] : story
        Story.find_or_create_story(id, shortname, record["url"], record["title"], record[score_name])
      end
      update_attributes(:last_updated => Time.now, :api_status => true)
    end
  end

  def update_from_other_sites
    hn = Site.where(:shortname => "hn").first if shortname != "hn"
    reddit = Site.where(:shortname => "reddit").first if shortname != "reddit"
    stories.order("updated_at DESC").limit(20).each do |story|
      if story.url.scan(/(imgur.com|reddit.com|twitter.com)/).blank?
        story.update_hn_points if shortname != "hn" && hn.api_status
        story.update_reddit_score if shortname != "reddit" && reddit.api_status
        story.update_facebook_likes
        story.update_total_count
      end
    end
  end

  def get_stories
    begin
      result = JSON.parse(get_http_response(top_stories_endpoint))
      stories = case shortname
                when "digg"       then result["stories"]
                when "reddit"     then result["data"]["children"]
                when "tweetmeme"  then result["stories"]
                when "hn"         then result["items"]
                end
      return stories
    rescue
      stories = []
    end
  end

  def update_from_tweetmeme(front_page_stories)
    front_page_stories.flatten.uniq.each do |story|
      story.update_tweetmeme_count unless story.site_name == "tweetmeme"
    end
  end

  def self.create_front_page(front_page_stories)
    front_page = FrontPage.create
    front_page.stories << front_page_stories
  end
  
end

