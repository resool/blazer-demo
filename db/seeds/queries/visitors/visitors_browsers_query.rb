class VisitorsBrowsersQuery < BaseQuery
  private

  def description
    '4 most popular browsers'
  end

  def statement
    <<~SQL
        WITH browsers AS
     (SELECT browser,
             count(*)
        FROM ahoy_visits
       WHERE started_at > {start_time}
         AND started_at < {end_time}
    GROUP BY browser
    ORDER BY count desc),

             tops AS
     (SELECT *
        FROM browsers
       LIMIT 4),

             others AS
     (SELECT *
        FROM browsers
      OFFSET 4)

      SELECT *
        FROM tops
       UNION
      SELECT 'Other',
             SUM(count)
        FROM others
    SQL
  end
end
