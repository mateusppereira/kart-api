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

      it 'should return 5 ordered_pilots' do
        expect(JSON.parse(response.body)['ordered_pilots'].count).to eq(5)
      end

      it 'should return best_lap' do
        expect(JSON.parse(response.body)['best_lap']).to eq(62.852)
      end
    end
  end
end
