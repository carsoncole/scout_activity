class Unit < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :activities, dependent: :destroy
  has_many :users, dependent: :nullify
  has_many :votes, through: :activities

  validates :name, presence: true
  validates :name, length: { maximum: 38 }

  scope :example, -> { where(is_example: true) }
  scope :non_example, -> { where(is_example: false) }

  before_save :update_vote_counts!, if: proc { |u| u.votes_allowed_changed? }

  def votes_cast
    activities.sum(:votes_count)
  end

  def update_vote_counts!
    return if votes_allowed_was < votes_allowed

    users.each do |user|
      user.votes.order(created_at: :desc).limit(1).first.destroy while user.votes.count > votes_allowed
    end
  end
end
