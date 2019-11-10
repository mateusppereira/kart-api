require 'rails_helper'

RSpec.describe 'Kart', type: :request do
  describe 'POST /kart/parse-log' do
    context 'File not sent' do
      before { post '/api/kart/parse-log' }

      it 'should return bad_request' do
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'File sent' do
      before do 
        post '/api/kart/parse-log', params: { kartlog: File.new('bin/input.log') }
      end

      it 'should return success' do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
