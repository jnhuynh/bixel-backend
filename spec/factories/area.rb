FactoryGirl.define do
  factory :area do
    sequence :name do |n|
      "area#{n}"
    end
  end
end

