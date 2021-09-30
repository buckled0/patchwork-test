require "rails_helper"

RSpec.describe ExchangeService do
  subject do
    described_class.new(
      tickers: tickers,
      from: from,
      to: to
    )
  end

  context "Given two crypto currencies" do
    let(:call) { subject.call }
    let(:from) { "ETH" }
    let(:to) { "BTC" }
    let(:tickers) do
      [
        {
          "id" => "BTC",
          "price" => "100"
        },
        {
          "id" => "ETH",
          "price" => "50"
        }
      ]
    end

    it "Finds the exchange rate" do
      expect(call).to be_an_instance_of(Hash)
      expect(call.keys).to contain_exactly(:BTC, :ETH)
      expect(call[:BTC]).to eq("0.5")
    end
  end
end
