class Ingredient < ActiveRecord::Base
  belongs_to :foodstuff
  belongs_to :recipe
  belongs_to :unit

  validates :quantity,
    presence: true,
    numericality: true,
    inclusion: 0.1..9999
end
