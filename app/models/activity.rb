#TODO Add icon for community service
class Activity < ApplicationRecord
  belongs_to :unit, touch: true
  belongs_to :author, optional: true, class_name: 'User'
  has_many :votes, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many_attached :images

  scope :high_adventure, -> { where(is_high_adventure: true) }
  scope :non_high_adventure, -> { where(is_high_adventure: false) }
  scope :votable, -> { where(is_archived: false) }
  scope :archived, -> { where(is_archived: true) }

  validates :name, presence: true
  validates :name, length: { maximum: 75 }
  validates :summary_new, presence: true

  has_rich_text :summary
  has_rich_text :description
  has_rich_text :itinerary

  before_save :remove_votes_if_archived!, if: Proc.new {|a| a.is_archived_changed? && a.is_archived? }

  def activity_icons?
    if is_swimming || is_hiking || is_plane || is_camping || is_community_service || is_biking || is_cooking || is_virtual || is_international || is_merit_badge || is_high_adventure || is_fundraising || is_game
      true
    else
      false
    end
  end

  def self.duplicate(activity)
    new_activity  = activity.dup
    new_activity.is_author_volunteering = false
    new_activity.author_id = false
    new_activity.unit_id = nil
    new_activity.votes_count = 0
    new_activity.description = activity.description.dup
    new_activity.itinerary = activity.itinerary.dup
    new_activity
  end

  private

  def remove_votes_if_archived!
    votes.destroy_all
  end
end
