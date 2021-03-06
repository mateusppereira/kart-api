# frozen_string_literal: true

require 'time'

class ParserService
  RGX_PILOT = /(\d{3}) – ([A-Z]\.[A-Z]+)/.freeze
  RGX_LINE = /^(\d{2}:\d{2}:\d{2}\.\d{3}).*(\d+)\s+(\d+:\d+\.\d{3})\s+(\d+,\d+)/.freeze

  def initialize(lines)
    @lines = lines
  end

  def parsed_lines
    _header, *content_lines = @lines

    content_lines.map do |line|
      pilot_data = parse_pilot_data(line)
      lap_data = parse_lap_data(line)
      {
        timestamp: lap_data[:timestamp],
        number: lap_data[:number],
        duration: lap_data[:duration],
        avg_speed: lap_data[:avg_speed],
        cod_pilot: pilot_data[:cod],
        name_pilot: pilot_data[:name]
      }
    end
  end

  private

  def parse_pilot_data(line)
    infos = RGX_PILOT.match(line)
    {
      cod: Integer(Float(infos[1])),
      name: infos[2]
    }
  rescue
    raise ArgumentError, '[ERROR] Pilot data mal formed'
  end

  def parse_lap_data(line)
    lap_infos = RGX_LINE.match(line)
    {
      timestamp: Time.parse(lap_infos[1]),
      number: Integer(lap_infos[2]),
      duration: FormatHelper.duration_to_seconds(lap_infos[3]),
      avg_speed: Float(lap_infos[4].tr(',', '.'))
    }
  rescue
    raise ArgumentError, '[ERROR] Lap data mal formed'
  end
end
