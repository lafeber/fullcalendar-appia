class Appia::Agenda::AgendaOccurrence < Appia::Client
  # Returns the occurrences for a specific agenda item.
  #
  # @param client_id [Integer] The ID of the client
  # @return [Array<Appia::Agenda::AgendaOccurrence>] The occurrences of the agenda item.
  def self.by_client_id(client_id, from:, to:)
    response = get("agenda/clients/#{client_id}/agenda_occurrences?from=#{from}&to=#{to}")
    response[:body][:agendaOccurrences]
  end

  def self.to_occurrence(agenda_occurrence)
    {
      id: agenda_occurrence[:id],
      title: agenda_occurrence[:comment],
      start: "#{agenda_occurrence[:occurrenceDate]}T#{agenda_occurrence[:startTime]}",
      end: "#{agenda_occurrence[:occurrenceDate]}T#{agenda_occurrence[:endTime]}",
      color: "#80ae07",
      all_day: false,
      editable: false
    }
  end
end
