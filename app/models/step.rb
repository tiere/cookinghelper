class Step < ActiveRecord::Base
  belongs_to :recipe

  validates :name,
    presence: true,
    length: { minimum: 2, maximum: 60 },
    format: { with: /\A[a-zA-Z ]+\z/, message: 'can only contain letters' }

  validates :duration,
    presence: true,
    numericality: { only_integer: true },
    inclusion: { in: 60..86400, message: 'must be between 60 and 86400' }

  def duration_m
    self.duration.to_i / 60
  end

  def duration_m=(duration)
    self.duration = duration.to_i * 60
  end
end
