### Considerações
- Escolhi fazer uma API pois acredito que para testa-la ficaria mais fácil
- Configurei uma pipeline no gitlab com 3 stages:
  - Lint (rubocop)
  - Testes (rspec)
  - Deploy (heroku)
- Outras features que gostaria de ter entregue:
  - Rollbar/sentry para monitoramento
  - Kubernetes para deploy
  - Client para enviar o arquivo
  - Guardar historico de corridas


#### API
  [POST] https://kart-api-gympass.herokuapp.com/api/kart/parse-log - Enviar arquivo via form-data com key "kartlog" 
