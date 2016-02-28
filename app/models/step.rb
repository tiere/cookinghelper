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
            inclusion: { in: 60..86_400, message:
                         'must be between 1 minute and 24 hours' }

  def duration_h
    duration.to_i.divmod(60)[0].divmod(60)[0].divmod(60)[1] unless duration.nil?
  end

  def duration_m
    duration.to_i.divmod(60)[0].divmod(60)[1] unless duration.nil?
  end

  def duration_s
    duration.to_i.divmod(60)[1] unless duration.nil?
  end

  attr_writer :duration_h

  attr_writer :duration_m

  attr_writer :duration_s

  def sum_durations
    unless @duration_h.nil? && @duration_m.nil? && @duration_s.nil?
      hours = @duration_h.to_i * 60 * 60
      minutes = @duration_m.to_i * 60
      seconds = @duration_s.to_i

      self.duration = hours + minutes + seconds
    end
  end
end
