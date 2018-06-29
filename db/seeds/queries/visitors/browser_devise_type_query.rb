class BrowserDeviseTypeQuery < BaseQuery

  private

  def description
    'Most popular browsers for a certain devise type'
  end

  def statement
    <<~SQL
        WITH browsers AS
     (SELECT browser,
             count(*)
        FROM ahoy_visits
       WHERE started_at > {start_time}
         AND started_at < {end_time}
         AND LOWER(device_type) LIKE {device_type}
    GROUP BY browser
    ORDER BY count desc),

             tops AS
     (SELECT *
        FROM browsers
       LIMIT 10),

             others AS
     (SELECT *
        FROM browsers
      OFFSET 10)

      SELECT *
        FROM tops
       UNION
      SELECT 'Other',
             SUM(count)
        FROM others
    SQL
  end
end
