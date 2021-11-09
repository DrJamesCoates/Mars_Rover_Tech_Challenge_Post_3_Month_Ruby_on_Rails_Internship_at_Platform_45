class CreateRovers < ActiveRecord::Migration[6.1]
  def change
    create_table :rovers do |t|
      t.string :name
      t.string :heading
      t.string :x_coordinate
      t.string :y_coordinate
      t.references :plateau, null: false, foreign_key: true

      t.timestamps
    end
  end
end
