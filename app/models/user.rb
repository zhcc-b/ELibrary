class User < ApplicationRecord
  # Include devise and jtw modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_books, through: :bookmarks, source: :book

  validates :username, presence: true, uniqueness: true
end
