Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :foods
    resources :recipes do
      resources :recipe_foods
    end
  end

  get 'public-recipes-list', to: 'recipes#public_list'
  get 'general_shopping_list', to: 'recipes#shopping_list'

  root to: 'recipes#public_list'
end
