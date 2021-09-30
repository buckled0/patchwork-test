class NomicsController < ApplicationController
  before_action :validate_tickers, only: :get_ticker

  def get_ticker
    tickers = client.get_tickers(
      tickers: params["tickers"],
      convert: params["convert"]
    )

    tickers = TickerFieldsService.call(
      tickers: tickers,
      fields: params["fields"]
    )

    render json: { tickers: tickers }
  end

  def get_exchange
    tickers = client.get_tickers(
      tickers: [params["currency_from"],
      params["currency_to"]]
    )

    render json: ExchangeService.call(
      tickers: tickers,
      from: params["currency_from"],
      to: params["currency_to"]
    )
  end

  private

  def client
    @client ||= NomicsApi::Client.new(
      "35d3ca7c09f9794487f098683164e5ff5e8a574a"
    )
  end

  def ticker(ticker)
    OpenStruct.new(ticker)
  end

  def validate_tickers
    if params["tickers"].is_a?(String)
      render json: {
        msg: "Param tickers must be an array (tickers[]=)"
      }, status: 422
    end
  end
end
