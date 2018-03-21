class Promotion < ApplicationRecord
  has_many :promotion_users
  has_many :users, through: :promotion_users

  validates :start_date, :end_date, :discount, :user_message, presence: true
  validates :code, presence: true, uniqueness: true
  validates :internal_message, presence: true, uniqueness: true

  after_create :set_assigned_flag_if_users

  def assigned?
    assigned
  end

  def user_can_use_promotion? user
    return true unless assigned?
    users.include? user
  end

  private
  
  def set_assigned_flag_if_users
    return if users.blank?
    self.assigned = true
    self.save
  end
end
