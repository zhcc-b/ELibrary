class ReviewsController < ApplicationController
  before_action :set_book
  before_action :set_review, only: [ :edit, :update, :destroy ]
  before_action :require_user
  before_action :require_same_user, only: [ :edit, :update, :destroy ]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.book = @book
    @review.user = current_user

    if @review.save
      if Rails.env.development?
        # 发送通知给收藏该书的用户
        @review.book.users_who_bookmarked.each do |user|
          # 不给评论的作者自己发送通知
          unless user == current_user
            BookMailer.new_review_notification(user, @review).deliver_later
          end
        end
      end

      flash[:notice] = "Review was successfully created."
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def edit
    # @review is set by before_action
  end

  def update
    if @review.update(review_params)
      flash[:notice] = "Review was successfully updated."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    flash[:notice] = "Review was successfully deleted."
    redirect_to book_path(@book)
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def require_same_user
    if current_user != @review.user && !admin?
      flash[:alert] = "You can only edit or delete your own reviews."
      redirect_to book_path(@book)
    end
  end
end
