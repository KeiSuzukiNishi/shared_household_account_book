Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :incomes_expenses
  resources :users, only: [:show]
  resources :categories
  root "incomes_expenses#index"
end
