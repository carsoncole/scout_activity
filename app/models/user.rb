class User < ApplicationRecord
  include Clearance::User

  belongs_to :troop, optional: true
  has_many :votes, dependent: :destroy
  has_many :troops
  has_many :activities, dependent: :destroy, foreign_key: 'author_id'

  def votes_available
    troop.votes_allowed - votes.count
  end

  def votes_cast
    votes.count
  end

  def admin?
    is_admin
  end
end
