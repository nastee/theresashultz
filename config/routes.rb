Theresashultz::Application.routes.draw do
  resources :cats
  root to: 'home#index'
end
