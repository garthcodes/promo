class CreatePromotions < ActiveRecord::Migration[5.1]
  def change
    create_table :promotions do |t|
      t.date :start_date
      t.date :end_date
      t.integer :discount
      t.string :user_message
      t.string :internal_message
      t.string :code
      t.boolean :assigned, default: false

      t.timestamps
    end
  end
end
