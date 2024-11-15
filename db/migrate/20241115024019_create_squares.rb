class CreateSquares < ActiveRecord::Migration[7.1]
  def change
    create_table :squares do |t|
      t.string :location
      t.integer :x_coordinate
      t.integer :y_coordinate

      t.timestamps
    end
  end
end
