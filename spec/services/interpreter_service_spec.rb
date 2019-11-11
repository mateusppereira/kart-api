# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'InterpreterService' do
  context 'Interpreting data' do
    lines = File.readlines('bin/input.log')
    parsed_lines = ParserService.new(lines).parsed_lines
    result = InterpreterService.new(parsed_lines).perform

    it 'should return best_lap' do
      expect(result[:best_lap]).to eq(62.852)
    end

    it 'should not return distance_from_winner for winner' do
      expect { result[:ordered_pilots][0][:distance_from_winner] }.to raise_error(NoMethodError)
    end

    it 'should return distance_from_winner for others' do
      expect(result[:ordered_pilots][1][:distance_from_winner]).to eq(-3.58)
    end

    it 'first should have have min race_time' do
      min_race_time = result[:ordered_pilots].min { |report| report[:race_time] }
      expect(result[:ordered_pilots].first).to eq(min_race_time)
    end

    it 'last should have have max race_time' do
      max_race_time = result[:ordered_pilots].max { |report| report[:race_time] }
      expect(result[:ordered_pilots].last).to eq(max_race_time)
    end

    context 'When none pilot finished race' do
      before do
        allow_any_instance_of(PilotReport).to receive(:finished_race?).and_return(false)
        result = InterpreterService.new(parsed_lines).perform
      end

      it 'should return only winner' do
        expect(result[:ordered_pilots].count).to eq(1)
      end
    end
  end
end
