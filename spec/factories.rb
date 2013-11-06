FactoryGirl.define do

  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "swordfish"
    password_confirmation "swordfish"

    factory :admin do
      admin true
    end
  end

  factory :foodstuff do
    sequence(:name) { |n| "Corn#{n}" }
  end

  factory :unit do
    sequence(:name) { |n| "Kilograms#{n}" }
    sequence(:abbreviation) { |n| "kg#{n}" }
  end

  factory :category do
    sequence(:name) { |n| "Soup#{n}" }
  end

  factory :step do
    sequence(:name) { |n| "Boil water #{n}" }
    duration_s 900
  end

  factory :ingredient do
    sequence(:quantity) { |n| n }
    unit
    foodstuff
  end

  factory :recipe do
    sequence(:name) { |n| "Garlic Soup #{n}" }
    category
    user

    ignore do
      steps_count 1
    end

    after(:build) do |recipe, evaluator|
      evaluator.steps_count.times { recipe.steps << FactoryGirl.build(:step) }
      recipe.ingredients << FactoryGirl.build(:ingredient)
    end
  end
end