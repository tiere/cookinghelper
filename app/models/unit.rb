class Unit < ActiveRecord::Base
  has_many :ingredients
  validates :name,
    presence: true,
    length: { minimum: 2, maximum: 60 },
    format: { with: /\A[a-zA-Z0-9 ]+\z/ },
    uniqueness: true

  validates :abbreviation,
    presence: true,
    length: { minimum: 1, maximum: 10 },
    format: { with: /\A[a-zA-Z0-9]+\z/ },
    uniqueness: true
end
