class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string :make, null: false
      t.string :model, null: false
      t.integer :year, null: false
      t.string :vin, null: false
      t.string :color, default: 'black'
      t.string :category, default: 'car'
      t.integer :cylinders, default: 4
      t.float :displacement, default: 0
      t.integer :mpg, default: 0
      t.integer :hp, default: 0
      t.timestamps
    end

    add_index :cars, [:vin], unique: true
    add_index :cars, [:make, :model, :year], unique: true
  end
end