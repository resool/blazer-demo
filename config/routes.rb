Rails.application.routes.draw do
  devise_for :users
  authenticate :user, lambda { |u| u.admin? } do
    mount Blazer::Engine, at: 'blazer'
  end
end
