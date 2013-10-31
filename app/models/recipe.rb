class Recipe < ActiveRecord::Base
  has_many :ingredients
  has_many :foodstuffs, :through => :ingredients
  has_many :steps
  belongs_to :category
  belongs_to :user

  delegate :name, to: :category, prefix: true

  accepts_nested_attributes_for :steps, allow_destroy: true
  accepts_nested_attributes_for :ingredients, allow_destroy: true

  validates :name,
    presence: true,
    length: { minimum: 2, maximum: 60 },
    format: { with: /\A[a-zA-Z0-9 ]+\z/, message: "can only contain letters" }

  validates_associated :steps, :ingredients
  validates :steps, :ingredients, :category, :user, presence: true

  def duration_to_s
    self.steps.sum('duration')
  end

  def duration_to_m
    self.steps.sum('duration') / 60
  end

  def progress_bar_width
    case self.duration_to_m
    when 1..15
      return 30
    when 16..30
      return 50
    when 31..60
      return 80
    else
      return 100
    end
  end

  def progress_bar_class
    case self.progress_bar_width
    when 30
      return 'progress-green'
    when 50
      return 'progress-yellow'
    when 80
        return 'progress-orange'
    else
      return 'progress-red'
    end
  end
end
