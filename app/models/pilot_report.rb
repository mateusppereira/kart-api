class PilotReport
  RACE_LAPS = 4
  attr_reader :cod_pilot, :name_pilot, :number_laps, :race_time, :best_lap, :avg_speed

  def initialize(pilot_race)
    @cod_pilot = pilot_race[0][:cod_pilot]
    @name_pilot = pilot_race[0][:name_pilot]
    @number_laps = pilot_race.max { |lap| lap[:number] }[:number]
    @race_time = pilot_race.sum { |lap| lap[:duration] }
    @best_lap = pilot_race.min { |lap| lap[:duration] }[:duration]
    @avg_speed = pilot_race.sum { |lap| lap[:avg_speed] } / pilot_race.count
  end

  def finished_race?
    @number_laps == RACE_LAPS ? true : false
  end

  def to_h
    {
      cod_pilot: @cod_pilot,
      name_pilot: @name_pilot,
      number_laps: @number_laps,
      race_time: @race_time.round(2),
      best_lap: @best_lap.round(2),
      avg_speed: @avg_speed.round(2),
    }
  end

  def distance_from_winner(winner)
    Float(winner.race_time - @race_time).round(2)
  end
end