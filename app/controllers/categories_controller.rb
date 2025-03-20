class CategoriesController < ApplicationController
  before_action :set_category, only: [ :show, :edit, :update, :destroy ]
  before_action :require_admin, except: [ :index, :show ]

  def index
    @categories = Category.all
  end

  def show
    @books = @category.books
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "Category was successfully created."
      redirect_to @category
    else
      render :new
    end
  end

  def edit
    # @category is set by before_action
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category was successfully updated."
      redirect_to @category
    else
      render :edit
    end
  end

  def destroy
    if @category.books.count > 0
      flash[:alert] = "Cannot delete category that has books."
      redirect_to @category
    else
      @category.destroy
      flash[:notice] = "Category was successfully deleted."
      redirect_to categories_path
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
