class User < ApplicationRecord
  include Clearance::User

  belongs_to :unit, optional: true
  has_many :votes, dependent: :destroy
  has_many :activities, foreign_key: 'author_id', dependent: :nullify
  has_many :questions, dependent: :nullify
  has_many :answers, dependent: :nullify
  has_many :logs, dependent: :destroy

  scope :owner, -> { where(is_owner: true) }
  scope :admin, -> { where(is_admin: true) }
  scope :active, -> { where("last_sign_in_at > ?", Time.now - 7.days) }

  before_save :clear_votes!, if: Proc.new {|u| u.unit_id_changed?}

  def initialize(args)
    super(args)
    self.token = SecureRandom.hex unless self.token.present?
  end

  def votes_available
    unit.votes_allowed - votes.count
  end

  def votes_cast
    votes.count
  end

  def admin?
    is_admin
  end

  def clear_votes!
    votes.destroy_all
  end
end
