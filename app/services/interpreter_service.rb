class InterpreterService
  def initialize(race_data)
    @race_by_pilot = race_data.group_by { |lap| lap[:cod_pilot] }
  end

  def perform
    pilot_cods = @race_by_pilot.keys
    reports_by_pilot = reports_by_pilot(pilot_cods)
    ordered_pilots = reports_by_pilot
      .filter { |report| report.finished_race? }
      .sort_by { |report| report.race_time }
    winner, *others = ordered_pilots
    {
      best_lap: reports_by_pilot.min { |report| report.best_lap }.best_lap,
      ordered_pilots: [winner] | others_with_distance(winner, others)
    }
  end

  def reports_by_pilot(pilot_cods)
    pilot_cods.map {|cod| PilotReport.new(@race_by_pilot[cod]) }
  end

  def others_with_distance(winner, other_pilots)
    other_pilots.map do |pilot|
      {
        **pilot.to_h,
        distance_from_winner: pilot.distance_from_winner(winner)
      }
    end
  end
end