Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, only: [:show, :destroy]
  resources :categories
  root "incomes_expenses#index"
  get 'split_expenses/index'
  post 'split_expenses/calculate'

  resources :incomes_expenses do
    collection do
      get 'calendar'
      get 'day', to: 'incomes_expenses#day'
    end
  end
  
end
