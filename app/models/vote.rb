class Vote < ApplicationRecord
  validate :check_votes_allowed
  validate :voting_within_troop

  belongs_to :activity, counter_cache: true
  belongs_to :user, counter_cache: true

  private

  def check_votes_allowed
    errors.add(:base, "Maximum number of allowed votes has been reached") if self.user.votes_available == 0
  end

  def voting_within_troop
    if activity
      errors.add(:base, "Voting only allowed in connected unit") unless user.unit && user.unit == activity.unit
    end
  end
end
