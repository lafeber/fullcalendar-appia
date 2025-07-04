# frozen_string_literal: true

# Creates a Reynard client configured for the correct Appia gateway.
module AppiaClient
  VERSION_RE = /\Av\d/
  # Used to strip non-ASCII characters from the version string. The regular expression is
  # intentionally a bit more strict and only allows version numbers and Git commit hashes.
  UNSAFE_VERSION_RE = /[^A-Za-z0-9.-]/

  def self.appia_url(servers)
    if %w[development test].include?(Rails.env)
      servers.first.url
    else
      # On Nomad the URL for the API gateway is set through an environment variable.
      ENV.fetch("API_GATEWAY_URL", "")
    end
  end

  def self.user_agent
    # Include Caren3 so the request can be easily traced to this application from just the
    # request logs. Include the short release version so we can place the request in a deployment
    # timespan or find the originating container version. Include the Reynard version in case we
    # need to figure out a problem with a specific release.
    #
    # NOTE: only ASCII characters are allowed in HTTP request headers.
    "Caren3/#{short_release_version} Reynard/#{Reynard::VERSION}"
  end

  # Returns a short release version to keep the User-Agent readable.
  def self.short_release_version
    Rails.root.join("VERSION").read.strip
  end

  def self.headers
    {
      "User-Agent" => user_agent,
      "Accept" => "application/json",
      "X-Cupido-User-Name" => "administrator"
    }
  end

  def self.client
    @_client ||= begin
      reynard = Reynard.new(filename: Rails.root.join("openapi/consuming.yml").to_s)
      reynard.base_url(appia_url(reynard.servers))
        .logger(Rails.logger)
        .headers(headers)
    end
  end

  # Returns a Reynard::Context instance, which can be used to perform API requests on the
  # endpoints defined in openapi/consuming_server.yml.
  def appia
    AppiaClient.client
  end
end
