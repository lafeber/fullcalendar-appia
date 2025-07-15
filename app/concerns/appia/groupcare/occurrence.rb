class Appia::Groupcare::Occurrence < Appia::Client
  # Fetches occurrences for a specific client by their ID.
  #
  # @param client_id [Integer] The ID of the client.
  # @return [Array<Appia::Groupcare::Occurrence>] The occurrences for the client.
  def self.by_client_id(client_id)
    response = get("groupcare/clients/#{client_id}/occurrences")
    response["occurrences"]
  end

  def self.to_occurrence(occurrence)
    {
      id: occurrence["id"],
      title: occurrence["groupName"],
      start: occurrence["startTime"],
      end: occurrence["endTime"],
      color: "#00ff00",
      all_day: false,
      editable: false
    }
  end
end
