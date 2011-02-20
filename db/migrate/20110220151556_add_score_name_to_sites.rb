class AddScoreNameToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :score_name, :string
  end

  def self.down
    remove_column :sites, :score_name
  end
end
