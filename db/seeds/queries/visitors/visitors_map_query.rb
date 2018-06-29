class VisitorsMapQuery < BaseQuery
  private

  def statement
    <<~SQL
      SELECT lat,
             lng
        FROM ahoy_visits
       WHERE started_at >= {start_time}
         AND started_at <= {end_time}
    SQL
  end
end
