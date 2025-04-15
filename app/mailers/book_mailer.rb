class BookMailer < ApplicationMailer
  default from: "notifications@elibrary.com"

  # 发送新书籍通知
  def new_book_notification(user, book)
    @user = user
    @book = book
    mail(
      to: @user.email,
      subject: "New Book Added: #{@book.title}"
    )
  end

  # 发送新评论通知给收藏该书的用户
  def new_review_notification(user, review)
    @user = user
    @review = review
    @book = review.book
    mail(
      to: @user.email,
      subject: "New Review for #{@book.title}"
    )
  end
end
