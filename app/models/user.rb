class User < ApplicationRecord
  include Clearance::User

  belongs_to :troop, optional: true
  has_many :votes, dependent: :destroy
  has_many :activities, dependent: :destroy, foreign_key: 'author_id'
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy

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
