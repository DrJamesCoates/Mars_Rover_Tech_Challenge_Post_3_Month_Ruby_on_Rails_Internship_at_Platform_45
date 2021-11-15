require 'rails_helper'

RSpec.describe Rover, type: :model do
  
  it { should belong_to(:plateau) }

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:heading) }
  it { should validate_exclusion_of(:heading).in_array(%w(A B C D F G H I J K L M O P Q R T U V X Y Z)) }
  it { should validate_exclusion_of(:heading).in_array(%w(a..z)) }
  # test values are only uppercase

  
  it { should validate_presence_of(:x_coordinate) }
  it { should validate_numericality_of(:x_coordinate).only_integer }
  it { should validate_presence_of(:y_coordinate) }
  it { should validate_numericality_of(:y_coordinate).only_integer }

end
