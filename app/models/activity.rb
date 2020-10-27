#TODO Add icon for community service
class Activity < ApplicationRecord
  belongs_to :troop
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :votes, dependent: :destroy
  has_many_attached :images

  scope :high_adventure, -> {where(is_high_adventure: true)}
  scope :non_high_adventure, -> {where(is_high_adventure: false)}
  scope :votable, -> {where(is_archived: false)}

  validates :name, presence: true
  validates :name, length: { maximum: 175 }

  has_rich_text :summary
  has_rich_text :description
  has_rich_text :itinerary

  before_save :remove_votes_if_archived!, if: Proc.new {|a| a.is_archived_changed? && a.is_archived? }

  def activity_icons?
    if is_swimming || is_hiking || is_plane || is_camping || is_community_service || is_biking
      true
    else
      false
    end
  end

  private

  def remove_votes_if_archived!
    votes.destroy_all
  end
end
