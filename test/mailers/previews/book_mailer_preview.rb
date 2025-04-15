# Preview all emails at http://localhost:3000/rails/mailers/book_mailer
class BookMailerPreview < ActionMailer::Preview
  def new_book_notification
    user = User.first
    book = Book.last
    BookMailer.new_book_notification(user, book)
  end

  def new_review_notification
    user = User.first
    review = Review.last
    BookMailer.new_review_notification(user, review)
  end
end
