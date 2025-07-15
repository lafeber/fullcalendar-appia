class Appia::Moves::PlannedVisit < Appia::Client
  def self.by_client_id(id, from:, to:)
    response = get("moves/planned_visits/by_client_id/#{id}?from=#{from}&to=#{to}")
    response[:body][:plannedVisits]
  end

  def self.to_occurrence(planned_visit)
    return unless planned_visit[:calculatedStart].present? && planned_visit[:totalDuration].present?

    {
      id: planned_visit[:id],
      title: planned_visit[:plancards].map { |h| h[:hourTypeName] }.join(", "),
      start: planned_visit[:calculatedStart],
      end: planned_visit[:calculatedStart].to_datetime + planned_visit[:totalDuration].seconds,
      color: "#451209", # Default color, can be customized
      all_day: false,
      editable: false
    }
  end
end
