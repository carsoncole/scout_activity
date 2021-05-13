class UnitVote < ApplicationRecord
  validate :check_votes_allowed
  validate :voting_within_troop

  belongs_to :activity, counter_cache: true
  belongs_to :user

  after_save :increment_vote_count!
  before_destroy :decrement_vote_count!

  private

  def increment_vote_count!
    if activity.unit.example?
      user.increment!(:example_unit_votes_count)
    else
      user.increment!(:unit_votes_count)
    end
  end

  def decrement_vote_count!
    if activity.unit.example?
      user.decrement!(:example_unit_votes_count)
    else
      user.decrement!(:unit_votes_count)
    end
  end

  def check_votes_allowed
    errors.add(:base, 'Maximum number of allowed votes has been reached') if user&.unit_votes_available&.zero?
  end

  def voting_within_troop
    errors.add(:base, 'Voting only allowed in connected unit or in Example unit') unless (self&.user&.unit && self&.user.unit == activity.unit) || activity.unit.example?
  end
end
