class CreateFrontPageStories < ActiveRecord::Migration
  def self.up
    create_table :front_page_stories do |t|
      t.integer   :front_page_id
      t.integer   :story_id
      t.integer   :score

      t.timestamps
    end
  end

  def self.down
    drop_table :front_page_stories
  end
end
