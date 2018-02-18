FactoryBot.define do
  factory :product do
    sequence(:id) { |n| "pid#{n}" }

    association :supplier
  end

  factory :supplier do
    sequence(:id) { |n| "sid#{n}" }
  end
end