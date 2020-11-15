class Question < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :activity
  has_many :answers, dependent: :destroy

  validates :content, presence: true
end
