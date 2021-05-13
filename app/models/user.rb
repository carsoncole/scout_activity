class User < ApplicationRecord
  include Clearance::User

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } # this allows bad emails such as "test@examplecom"

  belongs_to :unit, optional: true
  has_many :unit_votes, dependent: :destroy
  has_many :activities, foreign_key: 'author_id', dependent: :nullify
  has_many :questions, dependent: :nullify
  has_many :answers, dependent: :nullify
  has_many :logs, dependent: :destroy

  scope :owner, -> { where(is_owner: true) }
  scope :admin, -> { where(is_admin: true) }
  scope :app_admin, -> { where(is_app_admin: true) }
  scope :active, -> { where('last_sign_in_at > ?', Time.now - 7.days) }

  before_save :clear_unit_votes!, if: proc { |u| u.unit_id_changed? }
  before_save :remove_admin!, if: proc { |u| u.unit_id_changed? && u.persisted? }

  def initialize(args)
    super(args)
    self.token = SecureRandom.hex unless token.present?
  end

  def unit_votes_available
    unit.votes_allowed - unit_votes.joins(:activity).where("activities.unit_id = ?", unit_id).count
  end

  def example_votes_available
    Unit.example.first.votes_allowed - example_unit_votes_count
  end

  def name_email
    result = ''
    result = "#{last_name} #{result}" if last_name.present? && first_name.present?
    result = "#{first_name} #{result}" if first_name.present?
    if result.present?
      "#{result}(#{email})"
    else
      email
    end
  end

  def admin?
    is_admin
  end

  def owner?
    is_owner
  end

  def admin_or_owner?
    admin? || owner?
  end

  def clear_unit_votes!
    unit_votes.destroy_all
  end

  def remove_admin!
    self.is_admin = false
  end
end
