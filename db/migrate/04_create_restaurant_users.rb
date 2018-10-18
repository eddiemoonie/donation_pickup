class CreateRestaurantUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :restaurant_users do |t|
      t.integer :user_id
      t.integer :restaurant_id
    end
  end
end
