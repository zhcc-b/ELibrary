class ReviewSerializer
  include JSONAPI::Serializer

  attributes :id, :content, :rating, :created_at

  belongs_to :user
  belongs_to :book
end
