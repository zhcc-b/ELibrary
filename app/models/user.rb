class User < ApplicationRecord
  has_secure_password

  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_books, through: :bookmarks, source: :book

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
end
