class InfoController < ApplicationController

  def stats
    @sites = Site.all
  end

  def about
  end

  def roadmap
  end

end

