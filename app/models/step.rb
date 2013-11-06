class Step < ActiveRecord::Base
  before_validation :sum_durations

  belongs_to :recipe

  validates :name,
    presence: true,
    length: { minimum: 2, maximum: 60 },
    format: { with: /\A[a-zA-Z0-9 ]+\z/,
              message: 'can only contain letters and numbers' }

    validates :duration,
    presence: true,
    numericality: { only_integer: true },
    inclusion: { in: 60..86400, message:
                 'must be between 1 minute and 24 hours' }

  def duration_h
    unless self.duration.nil?
      self.duration.to_i.divmod(60)[0].divmod(60)[0].divmod(60)[1]
    end
  end

  def duration_m
    self.duration.to_i.divmod(60)[0].divmod(60)[1] unless self.duration.nil?
  end

  def duration_s
    self.duration.to_i.divmod(60)[1] unless self.duration.nil?
  end

  def duration_h=(duration)
    @duration_h = duration
  end

  def duration_m=(duration)
    @duration_m = duration
  end

  def duration_s=(duration)
    @duration_s = duration
  end

  def sum_durations
    unless @duration_h.nil? && @duration_m.nil? && @duration_s.nil?
      hours = @duration_h.to_i * 60 * 60
      minutes = @duration_m.to_i * 60
      seconds = @duration_s.to_i

      self.duration = hours + minutes + seconds
    end
  end
end