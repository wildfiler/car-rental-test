class CreateRent < ActiveRecord::Migration[6.1]
  def change
    create_table :rents do |t|
      t.belongs_to :car
      t.date :start_at
      t.date :end_at
      t.check_constraint 'start_at <= end_at', name: 'correct_period'
      t.timestamps
    end
  end
end
