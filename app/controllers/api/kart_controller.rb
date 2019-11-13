module Api
  class KartController < ActionController::API
    def parse_log
      params.require(:kartlog)

      lines = File.readlines(params[:kartlog].path)
      parsed_data = ParserService.new(lines).parsed_lines
      result = InterpreterService.new(parsed_data).perform

      render json: result
    rescue ActionController::ParameterMissing
      render json: { message: 'Arquivo de log não enviados' }, status: :bad_request
    rescue ArgumentError => exception
      render json: { message: exception }, status: :bad_request
    end
  end
end
