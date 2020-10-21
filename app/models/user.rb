class User < ApplicationRecord
  include Clearance::User

  has_many :votes, dependent: :destroy
  has_many :troops, dependent: :destroy
  has_many :activities, dependent: :destroy

  def votes_available
    20 - votes.count
  end

  def admin?
    is_admin
  end
end
