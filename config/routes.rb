Rails.application.routes.draw do
  devise_for :users
  resources :incomes_expenses
  resources :users
  resources :categories
  root "incomes_expenses#index"

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
