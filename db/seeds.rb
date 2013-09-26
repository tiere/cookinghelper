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
                      { name: 'grams', abbreviation: "g" },
                      { name: 'units', abbreviation: "kpl" }
])
