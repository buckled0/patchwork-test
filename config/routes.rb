Rails.application.routes.draw do
  get "/nomics/ticker", to: "nomics#get_ticker", as: "ticker"
  get "/nomics/exchange", to: "nomics#get_exchange", as: "exchange"
end
