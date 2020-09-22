Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "posts#index"

  resources :posts do
    resources :blocks do
      member do
        patch :move
      end
    end
  end
end
