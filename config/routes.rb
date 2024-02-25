Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, only: [:show, :destroy]
  resources :categories
  root "incomes_expenses#index"

  resources :incomes_expenses do
    collection do
      get 'calendar'
    end
  end
end
