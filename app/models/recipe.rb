class Recipe < ActiveRecord::Base
  has_and_belongs_to_many :ingredients
  has_many :steps
  
  accepts_nested_attributes_for :steps
  
  validates :name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :ingredients, presence: true
  validates_associated :steps
end
