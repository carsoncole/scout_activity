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
  scope :app_admin, -> { where(is_app_admin: true)}
  scope :active, -> { where("last_sign_in_at > ?", Time.now - 7.days) }

  before_save :clear_votes!, if: Proc.new {|u| u.unit_id_changed?}
  before_save :remove_admin!, if: Proc.new {|u| u.unit_id_changed? && u.persisted? }

  def initialize(args)
    super(args)
    self.token = SecureRandom.hex unless self.token.present?
  end

  def votes_available
    unit.votes_allowed - votes.count
  end

  def name_email
    result = ""
    result = last_name + ' ' + result if last_name.present? && first_name.present?
    result = first_name + ' ' + result if first_name.present?
    result = if result.present?
        result + '(' + email + ')'
      else
        email
      end
    result
  end

  def votes_cast
    votes.count
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

  def app_admin?
    is_app_admin
  end

  def clear_votes!
    votes.destroy_all
  end

  def remove_admin!
    self.is_admin = false
  end
end
