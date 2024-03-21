Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/admin/index', to: 'admin#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, only: [:show, :destroy]
  resources :categories
  resources :expense_records

  resources :incomes_expenses do
    collection do
      get 'calendar'
      get 'day', to: 'incomes_expenses#day'
    end
  end

  root "incomes_expenses#index"

  get 'charts/pie_chart_monthly', to: 'charts#pie_chart_monthly', as: 'pie_chart_monthly'
  get 'charts/pie_chart_yearly', to: 'charts#pie_chart_yearly', as: 'pie_chart_yearly'
  get 'charts/column_chart_monthly', to: 'charts#column_chart_monthly', as: 'column_chart_monthly'
  get 'charts/column_chart_yearly', to: 'charts#column_chart_yearly', as: 'column_chart_yearly'

  namespace :admin do
    get 'index', to: 'users#index'
    # resources :incomes_expenses
  end
end
