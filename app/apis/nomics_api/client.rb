module NomicsApi
  class Client
    API_ENDPOINT = "https://api.nomics.com/v1".freeze

    attr_reader :api_token

    def initialize(api_token = nil)
      @api_token = api_token
    end

    def get_tickers(ids)
      request(
        endpoint: "/currencies/ticker?ids=#{ids.join(",")}"
      )
    end

    private

    def client
      @_client ||= Faraday.new do |client|
        client.request :url_encoded
        client.adapter Faraday.default_adapter
        client.authorization :Bearer, api_token
      end
    end

    def request(endpoint:, params: {})
      response = client.public_send(:get, API_ENDPOINT + endpoint)
      Oj.load(response.body)
    end
  end
end
