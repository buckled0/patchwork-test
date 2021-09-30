class ExchangeService < ApplicationService
  def initialize(tickers:, from:, to:)
    @tickers = tickers
    @from = from
    @to = to
  end

  def call
    from_currency = ticker(tickers.select {|ticker| ticker["id"] == from }.first)
    to_currency = ticker(tickers.select {|ticker| ticker["id"] == to }.first)

    exchange_price = from_currency.price.to_f / to_currency.price.to_f

    {
      "#{from_currency.id}": "1",
      "#{to_currency.id}": "#{exchange_price}"
    }
  end

  private

  attr_reader :tickers, :from, :to

  def ticker(ticker)
    OpenStruct.new(ticker)
  end
end
