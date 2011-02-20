# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# Create Sites
Site.create(:name                   => "Digg",
            :url                    => "digg.com",
            :shortname              => "digg",
            :top_stories_endpoint   => "http://services.digg.com/2.0/story.getTopNews.json",
            :search_endpoint        => "",
            :story_details_endpoint => "")

Site.create(:name                   => "Reddit",
            :url                    => "reddit.com",
            :shortname              => "reddit",
            :top_stories_endpoint   => "http://www.reddit.com/.json",
            :search_endpoint        => "",
            :story_details_endpoint => "http://www.reddit.com/api/info.json?url=")

Site.create(:name                   => "Tweetmeme",
            :url                    => "tweetmeme.com",
            :shortname              => "tweetmeme",
            :top_stories_endpoint   => "http://api.tweetmeme.com/stories/recent.json?count=25",
            :search_endpoint        => "",
            :story_details_endpoint => "http://api.tweetmeme.com/url_info.xml?url=")

Site.create(:name                   => "HackerNews",
            :url                    => "news.ycombinator.com",
            :shortname              => "hn",
            :top_stories_endpoint   => "http://api.ihackernews.com/page",
            :search_endpoint        => "http://api.ihackernews.com/getid?url=",
            :story_details_endpoint => "http://api.ihackernews.com/post/")
