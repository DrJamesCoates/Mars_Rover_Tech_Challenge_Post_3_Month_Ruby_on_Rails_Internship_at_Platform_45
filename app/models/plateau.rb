class Plateau < ApplicationRecord

  has_many :rovers, dependent: :destroy

  validates_presence_of :name, :top_right_x_coordinate, :top_right_y_coordinate
  validates_inclusion_of :explored, in: [true, false]

end
