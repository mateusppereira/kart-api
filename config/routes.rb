# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    controller :kart do
      get '/kart', to: 'kart#index'
      post '/kart/parse-log', to: 'kart#parse_log'
    end
  end
end
