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
    front_page_stories = []
    Site.all.each do |site|
      # Fetch stories from sites
      site.fetch_and_save_stories
      # Update votes from other sites
      site.update_from_other_sites
      front_page_stories << Story.unscoped.where(:site_name => site.shortname).order("#{site.shortname} DESC").limit(5)
    end
    front_page_stories.flatten.uniq.each do |story|
      story.update_tweetmeme_count unless story.site_name == "tweetmeme"
    end
  end

  def fetch_and_save_stories
    stories = get_stories
    stories.each do |story|
      record = shortname == "reddit" ? story["data"] : story
      Story.find_or_create_story(id, shortname, record["url"], record["title"], record[score_name])
    end
  end

  def update_from_other_sites
    stories.limit(20).each do |story|
      if story.url.scan(/(imgur.com|reddit.com|twitter.com)/).blank?
        story.update_hn_points if shortname != "hn"
        story.update_reddit_score if shortname != "reddit"
        story.update_facebook_likes
        story.update_total_count
      end
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

end
