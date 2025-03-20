class BooksController < ApplicationController
  before_action :set_book, only: [ :show, :edit, :update, :destroy ]
  before_action :require_user, except: [ :index, :show ]
  before_action :require_admin, only: [ :edit, :update, :destroy ]
  # before_action :require_admin, only: [ :new, :create, :edit, :update, :destroy ]

  def index
    @books = Book.includes(:category).all
  end

  def show
    @review = Review.new
    @reviews = @book.reviews.includes(:user).order(created_at: :desc)
    @bookmark = current_user.bookmarks.find_by(book: @book) if logged_in?
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to @book
    else
      render :new
    end
  end

  def edit
    # @book is set by before_action
  end

  def update
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to @book
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    flash[:notice] = "Book was successfully deleted."
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :description, :published_date, :category_id)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
