class SplitExpensesController < ApplicationController
    def index
        if params[:user_incomes]
          user_incomes = params[:user_incomes].values.map(&:to_i)
          total_income = user_incomes.sum
          
          @results = user_incomes.map do |income|
            (income.to_f / total_income.to_f * 100).round
          end
        else
          @results = [] 
        end
    
        render :index
    end
        

end