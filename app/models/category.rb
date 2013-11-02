class Category < ActiveRecord::Base
  has_many :recipes

  validates :name,
    presence: true,
    length: { minimum: 2, maximum: 60 },
    format: { with: /\A[a-zA-Z0-9 ]+\z/,
              message: "can only contain letters and numbers" }
    end