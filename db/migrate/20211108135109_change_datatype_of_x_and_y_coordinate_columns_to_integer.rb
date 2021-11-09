class ChangeDatatypeOfXAndYCoordinateColumnsToInteger < ActiveRecord::Migration[6.1]
  def up 
    change_column :rovers, :x_coordinate, :integer
    change_column :rovers, :y_coordinate, :integer
  end

  def down
    change_column :rovers, :x_coordinate, :string
    change_column :rovers, :y_coordinate, :string
  end
end
