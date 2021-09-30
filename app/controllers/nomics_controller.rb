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

  private

  def client
    @client ||= NomicsApi::Client.new("35d3ca7c09f9794487f098683164e5ff5e8a574a")
  end
end
