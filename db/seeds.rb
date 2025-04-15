User.destroy_all

# 创建管理员用户
admin = User.create!(
  username: 'admin',
  email: 'admin@elibrary.com',
  password: 'password',
  role: 'admin'
)

# 创建普通用户
user = User.create!(
  username: 'user',
  email: 'user@elibrary.com',
  password: 'password',
  role: 'user'
)

# 创建分类
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

# 创建书籍
book_data = [
  { title: "The Great Gatsby", author: "F. Scott Fitzgerald", description: "A classic novel about the American Dream.", published_date: "1925-04-10" },
  { title: "To Kill a Mockingbird", author: "Harper Lee", description: "A novel about racial injustice in the American South.", published_date: "1960-07-11" },
  { title: "1984", author: "George Orwell", description: "A dystopian novel about totalitarianism.", published_date: "1949-06-08" },
  { title: "Pride and Prejudice", author: "Jane Austen", description: "A romantic novel about societal expectations.", published_date: "1813-01-28" },
  { title: "The Hobbit", author: "J.R.R. Tolkien", description: "A fantasy novel about a hobbit's journey.", published_date: "1937-09-21" }
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

# 创建评论
Book.all.each do |book|
  Review.create!(
    content: "A must-read classic that still resonates today.",
    rating: rand(3..5),
    user: user,
    book: book
  )
end

# 创建书签
Book.first(3).each do |book|
  Bookmark.create!(
    user: user,
    book: book,
    notes: "Want to read this again"
  )
end
