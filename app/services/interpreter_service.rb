# frozen_string_literal: true

class InterpreterService
  def initialize(race_data)
    @race_by_pilot = race_data.group_by { |lap| lap[:cod_pilot] }
  end

  def perform
    pilot_cods = @race_by_pilot.keys
    reports_by_pilot = reports_by_pilot(pilot_cods)
    ordered_pilots = reports_by_pilot
                     .filter(&:finished_race?)
                     .sort_by(&:race_time)
    winner, *others = ordered_pilots
    {
      best_lap: FormatHelper.seconds_to_s(reports_by_pilot.min_by(&:best_lap).best_lap),
      ordered_pilots: pilots_with_distance(winner, others)
    }
  end

  private

  def reports_by_pilot(pilot_cods)
    pilot_cods.map { |cod| PilotReport.new(@race_by_pilot[cod]) }
  end

  def pilots_with_distance(winner, other_pilots)
    others = other_pilots.map do |pilot|
      {
        **pilot.to_h,
        distance_from_winner: pilot.calculate_distance_from_winner(winner)
      }
    end
    [winner.to_h, *others]
  end
end
