json.extract! book, :id, :title, :edition, :picture, :author, :author, :isbn, :subject, :post_id, :created_at, :updated_at
json.url book_url(book, format: :json)