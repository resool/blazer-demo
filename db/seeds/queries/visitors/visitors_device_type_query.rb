class VisitorsDeviceTypeQuery < BaseQuery

  private

  def statement
    <<~SQL
       SELECT device_type,
              count(*)
         FROM ahoy_visits
        WHERE started_at >= {start_time}
          AND started_at <= {end_time}
     GROUP BY device_type
     ORDER BY count DESC
     SQL
  end
end
