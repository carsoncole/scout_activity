class Activity < ApplicationRecord
  belongs_to :troop
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :votes, dependent: :destroy

  scope :high_adventure, -> {where(is_high_adventure: true)}
  scope :non_high_adventure, -> {where(is_high_adventure: false) }

  validates :name, presence: true

  has_rich_text :summary
  has_rich_text :itinerary
end
