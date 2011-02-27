class FrontPageStory < ActiveRecord::Base

  # Associations
  belongs_to :front_page
  belongs_to :story

  after_create :update_score

  default_scope :order => "score desc"

  def update_score
    update_attribute("score", story.total_count)
  end

end

