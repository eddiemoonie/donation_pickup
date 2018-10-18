class CreateRestaurants < ActiveRecord::Migration[4.2]
  def change
    def create_table :restaurants do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :state
      t.string :zipcode
      t.integer :user_id
    end
  end
end
