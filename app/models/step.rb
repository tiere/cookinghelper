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

  def duration_h
    self.duration.to_i.divmod(60)[0].divmod(60)[0].divmod(60)[1] unless self.duration.nil?
  end

  def duration_m
    self.duration.to_i.divmod(60)[0].divmod(60)[1] unless self.duration.nil?
  end

  def duration_s
    self.duration.to_i.divmod(60)[1] unless self.duration.nil?
  end

  def duration_h=(duration)
    if duration == ''
      duration = 0
    end

    @duration_h = duration
  end

  def duration_m=(duration)
    if duration == ''
      duration = 0
    end

    @duration_m = duration
  end

  def duration_s=(duration)
    if duration == ''
      duration = 0
    end

    @duration_s = duration
  end

  def sum_durations
    hours = @duration_h.to_i * 60 * 60
    minutes = @duration_m.to_i * 60
    seconds = @duration_s.to_i

    self.duration = hours + minutes + seconds
  end

  before_validation do
    valid = false
    if !@duration_h.nil?
      valid = hour_is_valid?
    elsif !@duration_m.nil?
      valid = minute_is_valid?
    elsif !@duration_s.nil?
      valid = second_is_valid?
    end

    if valid
      sum_durations
    end
  end

  def hour_is_valid?
    begin
      if !Integer(@duration_h).between?(0, 24)
        errors.add(:duration_h, "must be between 0 and 24")
        false
      else
        true
      end
    rescue ArgumentError
      errors.add(:duration_h, 'is not a number')
      false
    end
  end

  def minute_is_valid?
    begin
      if !Integer(@duration_m).between?(0, 59)
        errors.add(:duration_m, "must be between 0 and 59")
        false
      else
        true
      end
    rescue ArgumentError
      errors.add(:duration_m, 'is not a number')
      false
    end
  end

  def second_is_valid?
    begin
      if !Integer(@duration_s).between?(0, 59)
        errors.add(:duration_s, "must be between 0 and 59")
        false
      else
        true
      end
    rescue ArgumentError
      errors.add(:duration_s, 'is not a number')
      false
    end
  end
end
