class InfoController < ApplicationController

  def stats
    @sites = Site.all
    @title = "Stats"
  end

  def about
    @title = "About"
  end

  def roadmap
    @title = "Roadmap"
  end

end

