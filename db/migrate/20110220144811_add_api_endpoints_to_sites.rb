class AddApiEndpointsToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :top_stories_endpoint, :string
    add_column :sites, :search_endpoint, :string
    add_column :sites, :story_details_endpoint, :string
  end

  def self.down
    remove_column :sites, :top_stories_endpoint
    remove_column :sites, :search_endpoint
    remove_column :sites, :story_details_endpoint
  end
end
