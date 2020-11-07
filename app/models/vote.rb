class Vote < ApplicationRecord
  validate :check_votes_allowed
  validate :voting_within_troop

  belongs_to :activity, counter_cache: true
  belongs_to :user, counter_cache: true

  private

  def check_votes_allowed
    if user
      errors.add(:base, "Maximum number of allowed votes has been reached") if user.votes_available == 0
    end
  end

  def voting_within_troop
    if activity
      errors.add(:base, "Voting only allowed in connected unit") if self&.user&.unit && self&.user.unit != activity.unit 
    end
  end
end
