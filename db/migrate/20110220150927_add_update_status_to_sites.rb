class AddUpdateStatusToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :update_status, :integer
  end

  def self.down
    remove_column :sites, :update_status
  end
end
