class NomicsController < ApplicationController
  def get_ticker
    render json: client.get_tickers(ticker_params)
  end

  private

  def client
    @client ||= NomicsApi::Client.new("35d3ca7c09f9794487f098683164e5ff5e8a574a")
  end

  def ticker_params
    params.require(:tickers)
  end
end
