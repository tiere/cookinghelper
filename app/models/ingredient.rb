class Ingredient < ActiveRecord::Base
  belongs_to :foodstuff
  belongs_to :recipe

  validates :quantity, presence: true
end
