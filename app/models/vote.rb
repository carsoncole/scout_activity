class Vote < ApplicationRecord
  belongs_to :activity, counter_cache: true
  belongs_to :user, counter_cache: true

  validate :check_votes_allowed

  private

  def check_votes_allowed
    errors.add(:base, "Maximum number of allowed votes has been reached") if self.user.votes_available == 0
  end

end
