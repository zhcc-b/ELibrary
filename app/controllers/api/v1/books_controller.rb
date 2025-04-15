class Api::V1::BooksController < Api::V1::BaseController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_book, only: [ :show, :update, :destroy ]

  def index
    @books = Book.all.includes(:category)
    render json: BookSerializer.new(@books, { include: [ :category ] }).serializable_hash
  end

  def show
    render json: BookSerializer.new(@book, { include: [ :category, :reviews ] }).serializable_hash
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      if Rails.env.development?
        User.all.each do |user|
          BookMailer.new_book_notification(user, @book).deliver_now
        end
      end

      render json: BookSerializer.new(@book).serializable_hash, status: :created
    else
      render json: { errors: @book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      render json: BookSerializer.new(@book).serializable_hash
    else
      render json: { errors: @book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    head :no_content
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :description, :published_date, :category_id, :cover)
  end
end
