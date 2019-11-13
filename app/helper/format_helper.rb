class FormatHelper
  def self.seconds_to_s(seconds)
    minutes, seconds = seconds.divmod(60)
    _hours, minutes = minutes.divmod(60)

    "#{minutes.to_s.rjust(2, '0')}:#{seconds.round(0).to_s.rjust(2, '0')}"
  end

  def self.duration_to_seconds(duration)
    minute, seconds = duration.split(':')
    (Float(minute) * 60) + Float(seconds)
  end
end
