class RegistredUsersQuery < BaseQuery
  private

  def statement
    <<~SQL
      SELECT email,
             CASE deactivated_at WHEN NULL THEN 'active' ELSE 'inactive' END,
             DATE(created_at) as registered_at,
             DATE(deactivated_at) as deactivated_at
        FROM users
       WHERE created_at >= {start_time}
         AND created_at <= {end_time}
    SQL
  end

  def description
   'Registred users - basic version'
  end
end
