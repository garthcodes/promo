class Promotion < ApplicationRecord
  has_many :promotion_users
  has_many :users, through: :promotion_users

  validates :start_date, :end_date, presence: true
  validates :code, presence: true, uniqueness: true
  validates :internal_message, presence: true, uniqueness: true, length: { in: 20..100 }
  validates :discount, presence: true, inclusion: 1000..3000
  validates :user_message, presence: true, length: { in: 20..100 }

  after_create :set_assigned_flag_if_users

  def assigned?
    assigned
  end

  def between_start_and_end_date?
    Date.today.between?(start_date, end_date)
  end

  def user_can_use_promotion?(user)
    return false unless between_start_and_end_date?
    return true unless assigned?
    return false unless users.include?(user)
    return false if promotion_redeemed?(user)
    true
  end

  def promotion_redeemed?(user)
    return false if promotion_users.find_by(user: user).redeemed_at.nil?
    true
  end

  private

  def set_assigned_flag_if_users
    return if users.blank?
    self.assigned = true
    self.save
  end
end
