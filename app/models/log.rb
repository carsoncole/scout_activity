class Log < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :unit, optional: true
end
