class Book < ApplicationRecord
  belongs_to :category

  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :users_who_bookmarked, through: :bookmarks, source: :user

  has_one_attached :cover

  validates :title, presence: true
  validates :author, presence: true
end
