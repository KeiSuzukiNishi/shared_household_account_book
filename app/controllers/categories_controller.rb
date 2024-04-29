class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:edit, :update, :destroy]

    def index
      @categories = Category.all

      respond_to do |format|
          format.html
          format.json { render :index, location: categories_url }
      end
    end
  
    def new
      @category = Category.new
    end
  
    def create
      @category = Category.new(category_params)
      
      respond_to do |format|
        if @category.save
            format.html { redirect_to categories_url, notice: t('shared_book.categorys_created') }
            format.json { render :index, status: :created, location: @category }
        else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def edit
    end
  
    def show
    end

    def update
      if @category.update(category_params)
        redirect_to categories_path, notice: 'Category was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
        @category.destroy!
        # binding.pry
        respond_to do |format|
          format.html { redirect_to categories_url, notice: t('shared_book.categories_destroyed') }
          format.json { head :no_content }
        end
    end

    private
  
    def set_category
      @category = Category.find(params[:id])
    end
  
    def category_params
      params.require(:category).permit(:name)
    end
end
