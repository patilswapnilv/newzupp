class Story < ActiveRecord::Base

  include UrlHelper

  HN_SEARCH_ENDPOINT = "http://api.ihackernews.com/getid?url="
  HN_POST_DETAILS_ENDPOINT = "http://api.ihackernews.com/post/"
  REDDIT_SEARCH_ENDPOINT = "http://www.reddit.com/api/info.json?url="

  #default_scope :order => "updated_at desc"

  # Associations
  belongs_to :site
  has_many :front_page_stories
  has_many :front_pages, :through => :front_page_stories

  def self.find_or_create_story(site_id, site_name, url, title, score)
    url_hash = create_hash(url)
    story = Story.where(:site_id => site_id, :url_hash => url_hash).first
    if story.blank?
      story = Story.create( :site_id => site_id, :title => title,
                            :url => url, :url_hash => url_hash,
                            :site_name => site_name)
    end
    story.update_attribute(site_name, score.to_i)
  end

  def update_hn_points
    begin
      search_url = HN_SEARCH_ENDPOINT + url
      result = JSON.parse(get_http_response(search_url))
      if result.blank?
        return
      else
        hn_post_id = result[0]
        post_details_url = HN_POST_DETAILS_ENDPOINT + hn_post_id.to_s
        begin
          result = JSON.parse(get_http_response(post_details_url))
          hn_points = result["points"]
          update_attribute("hn", hn_points.to_i)
        rescue
          logger.error "Unable to fetch HN post details for #{url}"
        end
      end
    rescue
      logger.error "Unable to search HN for #{url}"
    end
  end

  def update_reddit_score
    search_url = REDDIT_SEARCH_ENDPOINT + url
    begin
      result = JSON.parse(get_http_response(search_url))["data"]["children"]
      if result.blank?
        return
      else
        score = 0
        result.each do |child|
          score += child["data"]["score"]
        end
        update_attribute("reddit", score.to_i)
      end
    rescue
      logger.error "Unable to update reddit score for #{url}"
    end
  end

  def update_facebook_likes
    facebook_search_url = "http://api.facebook.com/method/fql.query?query=select%20total_count%20from%20link_stat%20where%20url='#{url}'&format=json"
    begin
      result = JSON.parse(get_http_response(facebook_search_url))
      update_attribute("facebook", result[0]["total_count"].to_i) if !result.blank?
    rescue
      logger.error "Unable to fetch facebook likes for #{url}"
    end
  end

  def update_tweetmeme_count
    post_detail_url = "http://api.tweetmeme.com/url_info.xml?url=#{url}"
    begin
      data = JSON.parse(get_http_response(post_detail_url))
      url_count  = Hpricot.parse(data).search("url_count").inner_html
      if !url_count.blank?
        update_attribute("tweetmeme", url_count.to_i)
        update_total_count
      end
    rescue
      logger.error "Unable to update tweeteme for #{url}"
    end
  end

  def update_total_count
    total = (10*digg + 3*reddit + 3*tweetmeme + 40*hn + facebook)
    update_attribute("total_count", total/10)
  end

end

