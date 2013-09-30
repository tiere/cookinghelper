class Recipe < ActiveRecord::Base
  has_many :ingredients
  has_many :foodstuffs, :through => :ingredients
  has_many :steps
  belongs_to :category

  delegate :name, to: :category, prefix: true

  accepts_nested_attributes_for :steps
  accepts_nested_attributes_for :ingredients

  validates :name,
    presence: true,
    length: { minimum: 2, maximum: 60 },
    format: { with: /\A[a-zA-Z ]+\z/ }

  validates_associated :steps, :ingredients
  validates :steps, :ingredients, :category, presence: true

  def duration
    self.steps.sum('duration')
  end
end
