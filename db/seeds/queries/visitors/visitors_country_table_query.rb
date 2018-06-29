class VisitorsCountryTableQuery < BaseQuery

  private

  def statement
    <<~SQL
         WITH countries AS
      (SELECT country,
              count(*)
         FROM ahoy_visits
        WHERE started_at > {start_time}
          AND started_at < {end_time}
     GROUP BY country
     ORDER BY count)

       SELECT country,
              count::text as count
         FROM countries
    SQL
  end
end
