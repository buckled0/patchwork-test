class TickerFieldsService < ApplicationService
  def initialize(tickers:, fields:)
    @tickers = tickers
    @fields = fields
  end

  def call
    return tickers unless fields.present?

    tickers.map do |ticker|
      ticker.select! do |k, v|
        fields.include?(k)
      end
    end
  end

  private

  attr_reader :tickers, :fields
end
