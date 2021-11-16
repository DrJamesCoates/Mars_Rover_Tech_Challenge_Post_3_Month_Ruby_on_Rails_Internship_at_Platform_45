class Plateau < ApplicationRecord

  has_many :rovers, dependent: :destroy

  validates_presence_of :name, :top_right_x_coordinate, :top_right_y_coordinate
  validates_inclusion_of :explored, in: [true, false]

  validates_numericality_of :top_right_x_coordinate, only_integer: true, greater_than_or_equal_to: 1
  validates_numericality_of :top_right_y_coordinate, only_integer: true, greater_than_or_equal_to: 1
  validate :check_plateau_rectangular, on: :create

  private

    def check_plateau_rectangular
      errors.add(:base, "Plateau must be a rectangel: top right x and y coordinates cannot be equal!") if top_right_x_coordinate == top_right_y_coordinate
    end
end
