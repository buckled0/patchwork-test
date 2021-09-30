module NomicsApi
  class Client
    API_ENDPOINT = "https://api.nomics.com/v1".freeze

    attr_reader :api_token

    def initialize(api_token = nil)
      @api_token = api_token
    end

    def get_tickers(tickers: "", convert: "")
      request(
        endpoint: "/currencies/ticker",
        params: {
          ids: tickers.join(","),
          convert: convert
        }
      )
    end

    private

    def client
      @_client ||= Faraday.new do |client|
        client.request :url_encoded
        client.adapter Faraday.default_adapter
        client.request :authorization, 'Bearer', @api_token
      end
    end

    def request(endpoint:, params: {})
      response = client.public_send(:get, API_ENDPOINT + endpoint, params)
      Oj.load(response.body)
    rescue Oj::ParseError
      raise ArgumentError.new "Too many requests"
    end
  end
end
