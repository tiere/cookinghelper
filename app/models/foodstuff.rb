class Foodstuff < ActiveRecord::Base
  has_many :ingredients
  has_many :recipes, :through => :ingredients

  validates :name,
    presence: true,
    length: { minimum: 2, maximum: 30 },
    uniqueness: true,
    format: { with: /\A[a-zA-Z0-9]+\z/, message: 'can only contain letters' }
end
