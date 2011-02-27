class StoriesController < ApplicationController

  def home
    @page = FrontPage.first
    @stories = @page.stories.order("total_count DESC")
    @title = "Hottest Stories on the web"
    @home = true
  end

  def digg
    @page = Site.where(:shortname => "digg").first
    @stories = @page.stories.order("updated_at DESC").limit(20)
    @title = "Popular stories on Digg"
    render :home
  end

  def reddit
    @page = Site.where(:shortname => "reddit").first
    @stories = @page.stories.order("updated_at DESC").limit(20)
    @title = "Popular stories on Reddit"
    render :home
  end

  def tweetmeme
    @page = Site.where(:shortname => "tweetmeme").first
    @stories = @page.stories.order("updated_at DESC").limit(20)
    @title = "Popular stories on Tweetmeme"
    render :home
  end

  def hackernews
    @page = Site.where(:shortname => "hn").first
    @stories = @page.stories.order("updated_at DESC").limit(20)
    @title = "Popular stories on HackerNews"
    render :home
  end

end

