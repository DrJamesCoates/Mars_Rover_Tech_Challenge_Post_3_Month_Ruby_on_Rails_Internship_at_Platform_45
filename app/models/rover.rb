class Rover < ApplicationRecord

  belongs_to :plateau

  validates_presence_of :name, :heading, :x_coordinate, :y_coordinate

  validates_length_of :heading, is: 1
  validates_exclusion_of :heading, in: %w(A B C D F G H I J K L M O P Q R T U V X Y Z)
  validates_exclusion_of :heading, in: %w(a..z)

  validates_numericality_of :x_coordinate, only_integer: true
  validates_numericality_of :y_coordinate, only_integer: true

  validate :check_on_plateau, on: :update

  private

    def check_on_plateau
      plateau = Plateau.find_by(id: plateau_id)
      if x_coordinate > plateau.top_right_x_coordinate
        errors.add(:x_coordinate, "can't be greater than the plateau top right x coordinate!")
      elsif y_coordinate > plateau.top_right_y_coordinate
        errors.add(:y_coordinate, "can't be greater than the plateau top right y coordinate!")
      end
    end
end
