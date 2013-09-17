class Recipe < ActiveRecord::Base
  has_and_belongs_to_many :ingredients
  
  validates :name, presence: true, length: { minimum: 2, maximum: 30 }
end
