class Troop < ApplicationRecord
  has_many :activities, dependent: :destroy
  belongs_to :user, optional: true
  belongs_to :owner, optional: true, class_name: 'User'

  validates :unit_name, presence: true
  validates :unit_name, length: { maximum: 35 }
end
