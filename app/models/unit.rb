class Unit < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :activities, dependent: :destroy
  has_many :users

  validates :name, presence: true
  validates :name, length: { maximum: 35 }

  def owners
    users.where(is_owner: true)
  end
end
