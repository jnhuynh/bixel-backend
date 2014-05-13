FactoryGirl.define do
  factory :player do
    sequence :name do |n|
      "player#{n}"
    end

    x 0
    y 0
  end
end

