require "rails_helper"

RSpec.describe NomicsApi::Client do
  subject { described_class.new("35d3ca7c09f9794487f098683164e5ff5e8a574a") }

  describe "get_ticker", vcr: true do
    context "when given a ticker" do
      it "returns all ticker information" do
        expect(subject.get_tickers(tickers: ["BTC"])).to be_an_instance_of(Array)
      end
    end

    context "when given multiple tickers" do
      let(:ticker_info) { subject.get_tickers(tickers: ["BTC", "XRP", "ETH"]) }

      it "returns all ticker information" do
        expect(ticker_info).to be_an_instance_of(Array)
        expect(ticker_info.length).to equal(3)
      end
    end

    context "when given an incorrect ticker" do
      let(:ticker_info) { subject.get_tickers(tickers: ["Sausage"]) }

      it "returns empty ticker information" do
        expect(ticker_info).to be_an_instance_of(Array)
        expect(ticker_info).to be_empty
      end
    end

    context "when given a conversion" do
      let(:ticker_info) do
        subject.get_tickers(
          tickers:["BTC"],
          convert: "GBP"
        )
      end

      it "returns all ticker information" do
        expect(ticker_info).to be_an_instance_of(Array)
        expect(ticker_info.length).to equal(1)
      end
    end
  end
end
