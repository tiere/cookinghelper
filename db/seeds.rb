# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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

recipe_names = [
  'Cheese cake', 'Carrot pie', 'Roasted potato with sausages',
  'Avocado salad', 'Bratwurst with mashed potatoes', 'Beef stew', 'Garlic metloaf',
  'Vegetarian pasta', 'Chicken with rice', 'Mozzarella Pizza', 'Pasta Bolognese',
  'Blue cheese pizza', 'Beef Jerky', 'Fish Sticks', 'Mashed Potatoes', 'Rice with curry',
  'Vegetarian Hamburgers', 'Tuna Sandwich', 'Blueberry pie', 'Apple pie', 'Chicken Tortillas'
]

recipe_names.each do |name|
  steps = Step.create!([
    { name: 'Boil water', duration: rand(60..3600) },
    { name: 'Slice carrots', duration: rand(60..3600) },
    { name: 'Peel potatoes', duration: rand(60..3600) }
  ])

  ingredients = Ingredient.create!([
    { quantity: 4, unit: units[rand(0..3)], foodstuff: foodstuffs[rand(0..3)] },
    { quantity: 600, unit: units[rand(0..3)], foodstuff: foodstuffs[rand(0..3)] }
  ])

  Recipe.create!([
    { name: name, steps: steps, ingredients: ingredients, category: categories[rand(0..3)] },
  ])
end
