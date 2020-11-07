class Unit < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :activities, dependent: :destroy
  has_many :users
  has_many :votes, through: :activities

  validates :name, presence: true
  validates :name, length: { maximum: 35 }

  scope :example, -> { where(is_example: true) }

  before_save :update_vote_counts!, if: Proc.new{|u| u.votes_allowed_changed?}

  def owners
    users.where(is_owner: true)
  end

  def votes_cast
    activities.sum(:votes_count)
  end

  def update_vote_counts!
    return if votes_allowed_was < votes_allowed
    users.each do |user|
      while user.votes.count > votes_allowed
        user.votes.order(created_at: :desc).limit(1).first.destroy
      end
    end
  end

end
