class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user, optional: true

  validates :content, presence: true
end
