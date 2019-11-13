module Api
  class KartController < ActionController::API
    def parse_log
      params.require(:kartlog)

      lines = File.readlines(params[:kartlog].path)
      parsed_data = ParserService.new(lines).parsed_lines
      result = InterpreterService.new(parsed_data).perform

      render json: result
    rescue ActionController::ParameterMissing
      render json: { message: 'Parâmetros não enviados' }, status: :bad_request
    end
  end
end