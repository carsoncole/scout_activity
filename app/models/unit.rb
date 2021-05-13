class Unit < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :activities, dependent: :destroy
  has_many :users, dependent: :nullify
  has_many :unit_votes, through: :activities

  validates :name, presence: true
  validates :name, length: { maximum: 38 }
  validates :is_example, uniqueness: true, if: Proc.new { |u| u.is_example }

  scope :example, -> { where(is_example: true) }
  scope :non_example, -> { where(is_example: false) }

  before_save :update_unit_vote_counts!, if: proc { |u| u.votes_allowed_changed? }

  def unit_votes_cast
    activities.sum(:unit_votes_count)
  end

  def example?
    is_example
  end

  def update_unit_vote_counts!
    return if votes_allowed_was < votes_allowed

    users.each do |user|
      user.unit_votes.order(created_at: :desc).limit(1).first.destroy while user.unit_votes.count > votes_allowed
    end
  end
end
