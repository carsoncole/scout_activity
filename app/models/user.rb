class User < ApplicationRecord
  include Clearance::User

  has_many :votes
  has_many :troops
  has_many :activities

  def votes_available
    20 - votes.count
  end

  def admin?
    is_admin
  end
end
