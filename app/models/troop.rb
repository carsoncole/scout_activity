class Troop < ApplicationRecord
  has_many :activities, dependent: :destroy

  validates :unit_name, presence: true
  validates :unit_name, length: { maximum: 35 }
end
