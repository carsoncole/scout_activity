class Troop < ApplicationRecord
  has_many :activities, dependent: :destroy
  belongs_to :user, optional: true

  validates :unit_name, presence: true
  validates :unit_name, length: { maximum: 35 }
end
