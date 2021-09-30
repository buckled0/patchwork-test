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
  end
end
