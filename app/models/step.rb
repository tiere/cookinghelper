class Step < ActiveRecord::Base
  belongs_to :recipe

  validates :name,
    presence: true,
    length: { minimum: 2, maximum: 60 },
    format: { with: /\A[a-zA-Z ]+\z/ }

  validates :duration,
    presence: true,
    numericality: { only_integer: true },
    inclusion: 60..86400
end
