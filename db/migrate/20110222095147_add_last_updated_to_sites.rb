class AddLastUpdatedToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :last_updated, :datetime
  end

  def self.down
    remove_column :sites, :last_updated
  end
end
