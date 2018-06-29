class ComeAndGoQuery < BaseQuery

  private

  def description
   'Registred users - deactivated users'
  end

  def statement
    <<~SQL
        WITH registered_users AS
     (SELECT COUNT(*) AS value,
             DATE(created_at) AS date FROM users
       WHERE deactivated_at IS NULL
    GROUP BY date
    ORDER BY date),

             deactivated_users AS
     (SELECT COUNT(*) AS value,
             DATE(deactivated_at) AS date FROM users
       WHERE deactivated_at IS NOT NULL
    GROUP BY date
    ORDER BY date)

      SELECT registered_users.date,
             COALESCE(registered_users.value, 0) - COALESCE(deactivated_users.value, 0) AS value,
             0 as target
        FROM registered_users
   LEFT JOIN deactivated_users
          ON deactivated_users.date = registered_users.date
       WHERE registered_users.date > {start_time}
         AND registered_users.date < {end_time}
    SQL
  end
end
