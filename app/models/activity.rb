# TODO: Add icon for community service
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
  scope :troop, -> { where(is_troop: true) }
  scope :pack, -> { where(is_pack: true) }
  scope :covid_safe, -> { where(is_covid_safe: true) }
  scope :fundraising, -> { where(is_fundraising: true) }

  validates :name, presence: true
  validates :name, length: { maximum: 75 }
  validates :summary_new, presence: true

  has_rich_text :summary
  has_rich_text :description
  has_rich_text :itinerary

  before_save :remove_votes_if_archived!, if: proc { |a| a.is_archived_changed? && a.is_archived? }
  after_save :update_covid_safe_count!, if: proc { |a| a.is_covid_safe_previously_changed? }
  after_save :update_troop_count!, if: proc { |a| a.is_troop_previously_changed? }
  after_save :update_fundraising_count!, if: proc { |a| a.is_fundraising_previously_changed? }

  def types
    result = []
    result << 'swimming' if is_swimming
    result << 'hiking' if is_hiking
    result << 'camping' if is_camping
    result << 'biking' if is_biking
    result << 'cooking' if is_cooking
    result
  end

  def categories
    result = []
    result << 'community service' if is_community_service
    result << 'international' if is_international
    result << 'merit badge opportunities' if is_merit_badge
    result << 'High Adventure' if is_high_adventure
    result << 'fundraising' if is_fundraising
    result << 'virtual' if is_virtual
    result
  end

  def activity_icons?
    if is_swimming || is_hiking || is_plane || is_camping || is_community_service || is_biking || is_cooking || is_virtual || is_international || is_merit_badge || is_high_adventure || is_fundraising || is_game
      true
    else
      false
    end
  end

  def self.duplicate(activity)
    new_activity = activity.dup
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

  def update_covid_safe_count!
    return unless unit.is_example?

    unit.update(covid_safe_count: unit.activities.covid_safe.count)
  end

  def update_fundraising_count!
    return unless unit.is_example?

    unit.update(fundraising_count: unit.activities.fundraising.count)
  end

  def update_troop_count!
    return unless unit.is_example?

    unit.update(troop_count: unit.activities.count)
  end
end
