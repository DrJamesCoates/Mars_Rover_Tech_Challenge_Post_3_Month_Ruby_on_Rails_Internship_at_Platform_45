FactoryBot.define do
  factory :rover do
    name { "Henlo" }
    x_coordinate { 5 }
    y_coordinate { 4 }
    heading { "N" }
    plateau_id { 1 }
  end
end