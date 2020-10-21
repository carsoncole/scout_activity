class User < ApplicationRecord
  include Clearance::User

  has_many :votes

  def votes_available
    20 - votes.count
  end
end
