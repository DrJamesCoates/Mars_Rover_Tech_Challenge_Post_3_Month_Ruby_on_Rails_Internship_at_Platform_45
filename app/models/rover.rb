class Rover < ApplicationRecord

  belongs_to :plateau

  validates_presence_of :name, :heading, :x_coordinate, :y_coordinate

  validates_length_of :heading, is: 1
  validates_exclusion_of :heading, in: %w(A B C D F G H I J K L M O P Q R T U V X Y Z)
  validates_exclusion_of :heading, in: %w(a..z)
  # ensure values for heading are only uppercase

  # ensure coordinates can only be less than or equal to the values of
  # the top right coordinate values of the plateau
  validates_numericality_of :x_coordinate, only_integer: true
  validates_numericality_of :y_coordinate, only_integer: true
end
