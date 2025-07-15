# frozen_string_literal: true

require "faraday"

module Appia
  class Client
    # TODO get this from consuming.yml for staging / production
    BASE_URL = "http://localhost:9000/api/"

    def self.client
      @client ||= begin
        options = {
          request: {
            open_timeout: 10,
            read_timeout: 10
          },
          headers: {
            "User-Agent" => "Caren3/3.0.0 Appia/1.0",
            "Accept" => "application/json",
            "X-Cupido-User-Name" => "administrator"
          }
        }
        Faraday.new(url: BASE_URL, **options) do |config|
          config.request :json
          config.response :json, parser_options: {symbolize_names: true}
          config.response :raise_error
          config.response :logger, Rails.logger, headers: true, bodies: true, log_level: :debug
        end
      end
    end

    def self.request(http_method:, endpoint:, body: {})
      response = client.public_send(http_method, endpoint, body)
      {
        status: response.status,
        body: response.body
      }
    end

    def self.get(endpoint)
      request(http_method: :get, endpoint: endpoint)
    end
  end
end
