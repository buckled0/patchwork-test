require "rails_helper"

RSpec.describe NomicsController do
  subject { response }

  describe "GET ticker", vcr: true do
    before do
      get(:get_ticker, params: params)
    end

    context "when given a ticker" do
      let(:params) {{ tickers: ["BTC"] }}

      it { is_expected.to have_http_status :success }

      it "is expected to be json" do
        expect(subject.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "when given ticker attributes" do
      let(:params) do
        {
          tickers: ["BTC"],
          fields: ["circulating_supply", "max_supply", "name", "symbol", "price"]
        }
      end

      it { is_expected.to have_http_status :success }

      it "has the correct keys" do
        expect(response_body["tickers"].first.keys).to contain_exactly(
          "circulating_supply", "max_supply", "name", "symbol", "price"
        )
      end
    end
  end

  def response_body
    JSON.parse(subject.body)
  end
end
