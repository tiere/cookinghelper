# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

foodstuffs = Foodstuff.create([
  { name: 'Tomato' },
  { name: 'Banana' },
  { name: 'Flour' },
  { name: 'Salt' }
])

units = Unit.create([
  { name: 'Kilograms', abbreviation: "kg" },
  { name: 'Liters', abbreviation: "l" },
  { name: 'Grams', abbreviation: "g" },
  { name: 'Units', abbreviation: "kpl" }
])

categories = Category.create([
  { name: 'Soup' },
  { name: 'Dessert' },
  { name: 'Salad' },
  { name: 'Main' }
])

recipes = Recipe.create([
  {
    name: 'Cheese Cake', category: categories[1],
    ingredients: [{ foodstuff: foodstuffs.first, quantity: 2, unit: units[3] }],
    steps: [{ name: 'Boil', duration: 3600 }]
  },
  { name: 'Pasta Bolognese', category: categories[3] },
  { name: 'Tuna salad', category: categories[2] }
])

# ingredients = Ingredient.create([
#   { recipe: recipes.first, foodstuff: foodstuffs.first, quantity: 2, unit: units[3] },
#   { recipe: recipes.first, foodstuff: foodstuffs[1], quantity: 2, unit: units[3] }
# ])

# steps = Step.create([
#   { name: 'Boil', recipe: recipes.first, duration: 3600},
#   { name: 'Slice onions', recipe: recipes.first, duration: 625}
# ])