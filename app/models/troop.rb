class Troop < ApplicationRecord
  has_many :activities

  validates :unit_number, presence: true
end
