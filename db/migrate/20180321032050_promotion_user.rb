class PromotionUser < ActiveRecord::Migration[5.1]
  def change
    create_table :promotion_users do |t|
      t.integer :user_id
      t.integer :promotion_id

      t.timestamps
    end
  end
end
