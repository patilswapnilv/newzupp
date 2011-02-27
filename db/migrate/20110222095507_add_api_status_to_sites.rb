class AddApiStatusToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :api_status, :boolean, :default => true
  end

  def self.down
    remove_column :sites, :api_status
  end
end
