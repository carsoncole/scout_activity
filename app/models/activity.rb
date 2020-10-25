#TODO Add icon for community service
class Activity < ApplicationRecord
  belongs_to :troop
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :votes, dependent: :destroy
  has_many_attached :images

  scope :high_adventure, -> {where(is_high_adventure: true)}
  scope :non_high_adventure, -> {where(is_high_adventure: false) }

  validates :name, presence: true
  validates :name, length: { maximum: 175 }

  has_rich_text :summary
  has_rich_text :description
  has_rich_text :itinerary
end
