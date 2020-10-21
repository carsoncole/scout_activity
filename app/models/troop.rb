class Troop < ApplicationRecord
  has_many :activities
  belongs_to :user, optional: true

  validates :unit_number, presence: true
end
