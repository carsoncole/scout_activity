class Unit < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :activities, dependent: :destroy

  validates :name, presence: true
  validates :name, length: { maximum: 35 }
end
