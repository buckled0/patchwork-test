require "rails_helper"

RSpec.describe TickerFieldsService do
  subject do
    described_class.new(
      tickers: tickers,
      fields: fields
    )
  end

  context "Given two crypto currencies" do
    let(:call) { subject.call }
    let(:fields) { ["name", "price"] }
    let(:tickers) do
      [
        {
          "id" => "BTC",
          "circulating_supply" => "2000",
          "max_supply" => "200000",
          "name" => "Bitcoin",
          "symbol" => "BTC",
          "price" => "100"
        },
        {
          "id" => "ETH",
          "circulating_supply" => "12321",
          "max_supply" => "300230",
          "name" => "Ethereum",
          "symbol" => "ETH",
          "price" => "50"
        }
      ]
    end

    it "Finds the exchange rate" do
      expect(call).to be_an_instance_of(Array)
      expect(call.first.keys).to contain_exactly("name", "price")
    end
  end
end
