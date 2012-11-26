Theresashultz::Application.routes.draw do

  resources :cats, :home
  root to: 'cats#index'
end
