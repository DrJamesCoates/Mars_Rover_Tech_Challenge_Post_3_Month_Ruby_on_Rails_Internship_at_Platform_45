
FactoryBot.define do
  factory :plateau do
    name { Faker::Address.country }
    top_right_x_coordinate { Faker::Number.number(digits: 10) }
    top_right_y_coordinate { Faker::Number.number(digits: 10) }
    explored { false }
  end
end