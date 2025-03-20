class BookmarksController < ApplicationController
  before_action :require_user

  def index
    @bookmarks = current_user.bookmarks.includes(:book)
  end

  def create
    @book = Book.find(params[:book_id])
    @bookmark = current_user.bookmarks.build(book: @book, notes: params[:notes])

    if @bookmark.save
      flash[:notice] = "Book was added to your bookmarks."
    else
      flash[:alert] = "Error adding bookmark: #{@bookmark.errors.full_messages.join(', ')}"
    end

    redirect_to book_path(@book)
  end

  def destroy
    @bookmark = current_user.bookmarks.find(params[:id])
    @book = @bookmark.book
    @bookmark.destroy

    flash[:notice] = "Book was removed from your bookmarks."
    redirect_to book_path(@book)
  end
end
