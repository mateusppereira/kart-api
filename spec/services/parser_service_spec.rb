require 'rails_helper'

RSpec.describe 'ParserService' do
  
  context 'Parsing lines' do
    lines = File.readlines('bin/input.log')
    parsed_lines = ParserService.new(lines).parsed_lines

    it 'should return all lines parsed' do
      _header, *content_lines = lines
      expect(parsed_lines.count).to eq(content_lines.count)
    end

    it 'should return field hora as timestamp' do
      expect(parsed_lines[0][:timestamp]).to eq('2019-11-10 23:49:08.277000000 -0300')
    end

    it 'should return formatted fields' do
      expect(parsed_lines[0][:cod_pilot]).to eq(38)
      expect(parsed_lines[0][:name_pilot]).to eq('F.MASSA')
      expect(parsed_lines[0][:avg_speed]).to eq(44.275)
      expect(parsed_lines[0][:duration]).to eq(62.852)
      expect(parsed_lines[0][:number]).to eq(1)
    end
  end
end