class Promotion < ApplicationRecord
  has_many :promotion_users
  has_many :users, through: :promotion_users
end
