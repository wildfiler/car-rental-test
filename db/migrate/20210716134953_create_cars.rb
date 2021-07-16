class CreateCars < ActiveRecord::Migration[6.1]
  def change
    create_table :cars do |t|
      t.string :model, null: false
      t.string :color, null: false
      t.integer :price, null: false
      t.check_constraint 'price > 0', name: 'positive_price'
      t.check_constraint 'char_length(model) > 0', name: 'model_presence'
      t.check_constraint 'char_length(color) > 0', name: 'color_presence'
      t.timestamps
    end
  end
end
