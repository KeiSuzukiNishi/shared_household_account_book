class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: [:show]

  
    def show
      if @user != current_user
        redirect_to incomes_expenses_path, alert: t('shared_book.could_not_access_other_users_account')
      end
    end
  
    private
  
    def set_user
      @user = User.find_by(id: params[:id])
      unless @user
        redirect_to incomes_expenses_path, alert: t('shared_book.there_is_no_user')
      end
    end
  end