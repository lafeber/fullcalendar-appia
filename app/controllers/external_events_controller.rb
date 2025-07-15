class ExternalEventsController < ApplicationController
  def agenda
    from = params[:from] || Time.zone.now.beginning_of_day
    to = params[:to] || Time.zone.now.end_of_day
    occurrences = Appia::Agenda::AgendaOccurrence.by_client_id(1, from: from, to: to)
    @events = occurrences.filter_map { |occurrence| Appia::Agenda::AgendaOccurrence.to_occurrence(occurrence) }
    render "events/index"
  end

  def moves
    from = params[:from] || Time.zone.now.beginning_of_day
    to = params[:to] || Time.zone.now.end_of_day
    visits = Appia::Moves::PlannedVisit.by_client_id(1, from: from, to: to)
    @events = visits.filter_map { |visit| Appia::Moves::PlannedVisit.to_occurrence(visit) }
    render "events/index"
  end

  def presence_logs
    presence_logs = Appia::Administration::PresenceLog.by_client_id(1)
    @events = presence_logs.filter_map { |log| Appia::Administration::PresenceLog.to_occurrence(log) }
    render "events/index"
  end
end
