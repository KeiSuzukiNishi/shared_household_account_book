Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/admin/index', to: 'admin#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :incomes_expenses
  resources :users, only: [:show, :destroy]
  resources :categories
  # resources :admins
  root "incomes_expenses#index"

  get 'charts/expenses_by_category', to: 'charts#expenses_by_category', as: 'expenses_by_category'

  namespace :admin do
    get 'index', to: 'users#index'
    # resources :incomes_expenses
  end
end
