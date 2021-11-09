class CreatePlateaus < ActiveRecord::Migration[6.1]
  def change
    create_table :plateaus do |t|
      t.string :name
      t.integer :top_right_x_coordinate
      t.integer :top_right_y_coordinate
      t.boolean :explored

      t.timestamps
    end
  end
end
