Rails.application.routes.draw do
<<<<<<< HEAD
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
=======
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "games#new"
  resources :games
>>>>>>> 67e0d0e7afbe353c80fbd0b87df272fadd6a9fa2
end
