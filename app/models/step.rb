class Step < ActiveRecord::Base
  belongs_to :recipe
  validates :name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :time, presence: true
end
