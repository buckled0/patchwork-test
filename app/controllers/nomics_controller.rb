class NomicsController < ApplicationController
  def get_ticker
    tickers_fields = client.get_tickers(
      tickers: params["tickers"],
      convert: params["convert"]
    )

    tickers_fields.map do |ticker|
      ticker.select! do |k, v|
        params["fields"].include?(k)
      end
    end if params["fields"].present?

    render json: { tickers: tickers_fields }
  end

  def get_exchange
    tickers = client.get_tickers(
      tickers: [params["currency_from"],
      params["currency_to"]]
    )

    from = ticker(tickers.select {|ticker| ticker["id"] == params["currency_from"] }.first)
    to = ticker(tickers.select {|ticker| ticker["id"] == params["currency_to"] }.first)

    exchange_price = from.price.to_f / to.price.to_f

    render json: {
      "#{from.id}": "1",
      "#{to.id}": "#{exchange_price}"
    }
  end

  private

  def client
    @client ||= NomicsApi::Client.new(
      ENV["NOMAD_API_KEY"]
    )
  end

  def ticker(ticker)
    OpenStruct.new(ticker)
  end
end
