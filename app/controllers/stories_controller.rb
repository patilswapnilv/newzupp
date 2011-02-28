class StoriesController < ApplicationController

  caches_page :home, :digg, :reddit, :tweetmeme, :hackernews

  def home
    @page = FrontPage.first
    @stories = @page.stories.order("total_count DESC")
    @title = "Hottest Stories on the web"
    @home = true
  end

  def digg
    @page = Site.where(:shortname => "digg").first
    @stories = @page.stories.order("updated_at DESC").limit(20)
    @title = "Digg - Popular Stories"
    render :home
  end

  def reddit
    @page = Site.where(:shortname => "reddit").first
    @stories = @page.stories.order("updated_at DESC").limit(20)
    @title = "Reddit - Popular Stories"
    render :home
  end

  def tweetmeme
    @page = Site.where(:shortname => "tweetmeme").first
    @stories = @page.stories.order("updated_at DESC").limit(20)
    @title = "Tweetmeme - Popular Stories"
    render :home
  end

  def hackernews
    @page = Site.where(:shortname => "hn").first
    @stories = @page.stories.order("updated_at DESC").limit(20)
    @title = "HackerNews - Popular Stories"
    render :home
  end

end

