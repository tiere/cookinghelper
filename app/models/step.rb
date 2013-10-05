class Step < ActiveRecord::Base
  belongs_to :recipe

  validates :name,
    presence: true,
    length: { minimum: 2, maximum: 60 },
    format: { with: /\A[a-zA-Z ]+\z/, message: 'can only contain letters' }

  validates :duration,
    presence: true,
    numericality: { only_integer: true },
    inclusion: { in: 60..86400, message: 'must be between 1 minute and 24 hours' }

  def duration_s
    self.duration.to_i.divmod(60)[1]
  end

  def duration_m
    self.duration.to_i.divmod(60)[0].divmod(60)[1]
  end

  def duration_h
    self.duration.to_i.divmod(60)[0].divmod(60)[0].divmod(60)[1]
  end

  def duration_s=(duration)
    @duration_s = duration.to_i
  end

  def duration_m=(duration)
    @duration_m = duration.to_i
  end

  def duration_h=(duration)
    @duration_h = duration.to_i
  end

  def sum_durations
    hours = @duration_h * 60 * 60
    minutes = @duration_m * 60
    seconds = @duration_s

    self.duration = hours + minutes + seconds
  end

  before_validation :sum_durations
end
