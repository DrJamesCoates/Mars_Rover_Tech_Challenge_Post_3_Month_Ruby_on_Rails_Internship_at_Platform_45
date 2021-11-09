require 'rails_helper'

RSpec.describe Plateau, type: :model do

  it { should have_many(:rovers).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:top_right_x_coordinate) }
  it { should validate_presence_of(:top_right_y_coordinate) }
  
end
