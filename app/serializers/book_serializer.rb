class BookSerializer
  include JSONAPI::Serializer

  attributes :id, :title, :author, :description, :published_date

  belongs_to :category
  has_many :reviews

  attribute :cover_url do |book|
    Rails.application.routes.url_helpers.url_for(book.cover) if book.cover.attached?
  end
end
