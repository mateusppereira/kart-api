# frozen_string_literal: true

require_relative '../../services/parser_service'

module Api
  class KartController < ActionController::API
    def index
      render json: { message: 'Hello' }
    end

    def parse_log
      params.require(:kartlog)

      lines = File.readlines('bin/input.log')
      parsed_data = ParserService.new(lines).parsed_lines
      result = InterpreterService.new(parsed_data).perform

      render json: result
    rescue ActionController::ParameterMissing
      render json: { message: 'Parâmetros não enviados' }, status: :bad_request
    end
  end
end
