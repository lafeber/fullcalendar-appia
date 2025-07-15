class Appia::Administration::PresenceLog < Appia::Client
  # Fetches presence logs for a specific client by their ID.
  #
  # @param client_id [Integer] The ID of the client.
  # @return [Array<Appia::Administration::PresenceLog>] The presence logs for the client.
  def self.by_client_id(client_id)
    response = get("administration/clients/#{client_id}/presence_logs")
    response[:body][:presenceLogs]
  end

  def self.to_occurrence(presence_log)
    {
      id: presence_log[:id],
      title: presence_log[:products].map { |p| p[:description] }.join(", "),
      start: presence_log[:startDate],
      end: presence_log[:endDate],
      color: "#ff00ff",
      all_day: false,
      editable: false
    }
  end
end
