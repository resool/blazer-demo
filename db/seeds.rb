load(Rails.root.join('db', 'seeds', 'users.rb')) if Rails.env.development?
load(Rails.root.join('db', 'seeds', 'query_loader.rb'))

QueryLoader.new.call
