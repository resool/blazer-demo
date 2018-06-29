require 'timecop'
require 'faker'

USER_COUNT = 1000

(USER_COUNT - User.count).times do |index|
  print "\n#{index} users processed" if index % 100 == 0
  print '.' if index % 10 == 0

  register_date = Faker::Time.between(1.year.ago, Time.current, :all)
  deactivate_date = Faker::Time.between(register_date, Time.current, :all)
  name = Faker::FunnyName.name,
  user = User.new(
    name: name,
    email: Faker::Internet.unique.safe_email(name),
    password: Faker::Internet.password(8)
  )

  Timecop.travel(register_date) { user.save }

  next if (1..3).to_a.sample % 3 != 0

  Timecop.travel(deactivate_date) { user.deactivate! }
end
