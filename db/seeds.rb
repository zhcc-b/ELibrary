# Create admin user
admin = User.create!(
  username: 'admin',
  email: 'admin@elibrary.com',
  password: 'password',
  role: 'admin'
)

# Create regular user
user = User.create!(
  username: 'user',
  email: 'user@elibrary.com',
  password: 'password',
  role: 'user'
)

# Create categories
categories = [
  { name: 'Fiction', description: 'Fictional works of literature' },
  { name: 'Non-Fiction', description: 'Factual and educational books' },
  { name: 'Science Fiction', description: 'Science-based speculative fiction' },
  { name: 'Mystery', description: 'Mystery and detective stories' },
  { name: 'Biography', description: 'Life stories of real people' }
]

categories.each do |category|
  Category.create!(category)
end

# Create books
book_data = [
  { title: "The Great Gatsby", author: "F. Scott Fitzgerald", description: "A classic novel about the American Dream.", published_date: "1925-04-10" },
  { title: "To Kill a Mockingbird", author: "Harper Lee", description: "A novel about racial injustice in the American South.", published_date: "1960-07-11" },
  { title: "1984", author: "George Orwell", description: "A dystopian novel about totalitarianism.", published_date: "1949-06-08" },
  { title: "Pride and Prejudice", author: "Jane Austen", description: "A romantic novel about societal expectations.", published_date: "1813-01-28" },
  { title: "The Hobbit", author: "J.R.R. Tolkien", description: "A fantasy novel about a hobbit's journey.", published_date: "1937-09-21" },
  { title: "Harry Potter and the Sorcerer's Stone", author: "J.K. Rowling", description: "A fantasy novel about a young wizard.", published_date: "1997-06-26" },
  { title: "The Catcher in the Rye", author: "J.D. Salinger", description: "A novel about teenage angst and alienation.", published_date: "1951-07-16" },
  { title: "To the Lighthouse", author: "Virginia Woolf", description: "A modernist novel about time and perception.", published_date: "1927-05-05" },
  { title: "Brave New World", author: "Aldous Huxley", description: "A dystopian novel about genetic engineering.", published_date: "1932-01-01" },
  { title: "The Lord of the Rings", author: "J.R.R. Tolkien", description: "An epic fantasy trilogy.", published_date: "1954-07-29" }
]

book_data.each do |book_info|
  Book.create!(
    title: book_info[:title],
    author: book_info[:author],
    description: book_info[:description],
    published_date: book_info[:published_date],
    category: Category.all.sample
  )
end

# Create reviews
books = Book.all
review_contents = [
  "Really enjoyed this book, highly recommend!",
  "A classic that still holds up today.",
  "Interesting premise but the execution was lacking.",
  "Couldn't put it down, finished it in one sitting.",
  "Well-written but not my favorite by this author."
]

books.each do |book|
  Review.create!(
    content: review_contents.sample,
    rating: rand(1..5),
    user: user,
    book: book
  )
end

# Create bookmarks
5.times do
  begin
    Bookmark.create!(
      user: user,
      book: Book.all.sample,
      notes: "Want to read this soon"
    )
  rescue ActiveRecord::RecordInvalid
    # Skip if we try to bookmark the same book twice
  end
end
