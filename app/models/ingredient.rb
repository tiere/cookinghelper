class Ingredient < ActiveRecord::Base
  belongs_to :foodstuff
  belongs_to :recipe
  belongs_to :unit

  delegate :name, to: :foodstuff, prefix: true
  delegate :name, to: :unit, prefix: true

  validates :quantity,
    presence: true,
    numericality: true,
    inclusion: 0.1..9999

  validates_associated :unit, :foodstuff
  validates :unit, :foodstuff, presence: true
end
