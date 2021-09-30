Rails.application.routes.draw do
  get "/nomics/ticker", to: "nomics#get_ticker", as: "ticker"
end
