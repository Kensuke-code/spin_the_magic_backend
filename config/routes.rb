Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :spin_gacha, only: [:index]
    end
  end
end
