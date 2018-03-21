class User < ApplicationRecord
  has_many :promotion_users
  has_many :promotions, through: :promotion_users
end
