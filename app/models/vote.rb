class Vote < ApplicationRecord
  belongs_to :activity, counter_cache: true
  belongs_to :user, counter_cache: true
end
