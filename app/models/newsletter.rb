class Newsletter < ApplicationRecord
  validates :subject, presence: true
  has_rich_text :content
end
