class Promotion < ApplicationRecord
  has_many :promotion_users
  has_many :users, through: :promotion_users

  validates :start_date, :end_date, :discount, :user_message, presence: true
  validates :code, presence: true, uniqueness: true
  validates :internal_message, presence: true, uniqueness: true

  validates :users, presence: true, if: :assigned?

  def assigned?
    return true if assigned == true
    false
  end
end
