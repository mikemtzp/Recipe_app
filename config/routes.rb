Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :foods
    resources :recipes do
      resources :recipe_foods
    end
  end

  get 'public-recipe-list', to: 'recipes#public_list'

  root to: "recipes#public_list"
end
