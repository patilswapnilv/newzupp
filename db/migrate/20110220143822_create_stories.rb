class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.integer     :site_id
      t.string      :title
      t.string      :url
      t.string      :url_hash
      t.string      :site_name
      t.integer     :digg,          :default => 0
      t.integer     :reddit,        :default => 0
      t.integer     :tweetmeme,     :default => 0
      t.integer     :hn,            :default => 0
      t.integer     :facebook,      :default => 0
      t.integer     :total_count,   :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :stories
  end
end
