foodstuffs = Foodstuff.create!([
                                 { name: 'Tomato' },
                                 { name: 'Banana' },
                                 { name: 'Flour' },
                                 { name: 'Salt' }
])

units = Unit.create!([
                       { name: 'Kilograms', abbreviation: "kg" },
                       { name: 'Liters', abbreviation: "l" },
                       { name: 'Grams', abbreviation: "g" },
                       { name: 'Units', abbreviation: "kpl" }
])

categories = Category.create!([
                                { name: 'Soup' },
                                { name: 'Dessert' },
                                { name: 'Salad' },
                                { name: 'Main' }
])

30.times do |n|
  User.create!(name: Faker::Name.name, email: "example#{n}@example.com",
               password: 'password', password_confirmation: 'password')
end

User.all.each do |user|
  recipe_names = [
    'Cheese cake', 'Carrot pie', 'Roasted potato with sausages',
    'Avocado salad', 'Bratwurst with mashed potatoes', 'Beef stew',
    'Garlic meatloaf', 'Vegetarian pasta', 'Chicken with rice',
    'Mozzarella Pizza', 'Pasta Bolognese', 'Blue cheese pizza', 'Beef Jerky',
    'Fish Sticks', 'Mashed Potatoes', 'Rice with curry', 'Vegetarian Hamburgers',
    'Tuna Sandwich', 'Blueberry pie', 'Apple pie', 'Chicken Tortillas'
  ]

  recipe_names.each.with_index do |name, i|
    steps = Step.create!([
                           { name: 'Boil water', duration: rand(60..900) },
                           { name: 'Slice carrots', duration: rand(60..900) },
                           { name: 'Peel potatoes', duration: rand(60..900) }
    ])

    ingredients = Ingredient.create!([
                                       { quantity: 4, unit: units[rand(0..3)],
                                         foodstuff: foodstuffs[rand(0..3)] },
                                       { quantity: 600, unit: units[rand(0..3)],
                                         foodstuff: foodstuffs[rand(0..3)] }
    ])

    Recipe.create!([
                     { name: "#{name} #{i}", steps: steps, ingredients: ingredients,
                       category: categories[rand(0..3)], user: user }
    ])
  end
end

User.create!(name: "testing", email: "testing@example.com",
             password: "swordfish", password_confirmation: "swordfish",
             admin: true)