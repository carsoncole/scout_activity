class Vote < ApplicationRecord
  validate :check_votes_allowed
  validate :voting_within_troop

  belongs_to :activity, counter_cache: true
  belongs_to :user, counter_cache: true

  private

  def check_votes_allowed
    errors.add(:base, 'Maximum number of allowed votes has been reached') if user&.votes_available&.zero?
  end

  def voting_within_troop
    errors.add(:base, 'Voting only allowed in connected unit') if activity && self&.user&.unit && self&.user.unit != activity.unit
  end
end
