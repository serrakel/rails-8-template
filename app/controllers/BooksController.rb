class BooksController < ApplicationController
  def new
    @book = Book.new

    render({ :template => "books/new" })
  end

  def create
    @book = Book.new

    @book.title = params.fetch("query_title")
    @book.author = params.fetch("query_author")
    @book.description = params.fetch("query_description")
    @book.cover_image_url = params.fetch("query_cover_image_url")
    @book.published_year = params.fetch("query_published_year")
    @book.isbn = params.fetch("query_isbn")

    @book.save

    redirect_to("/books/" + @book.id.to_s)
  end

  def show
    the_id = params.fetch("id")
    matching_books = Book.where({ :id => the_id })
    @book = matching_books.at(0)

    render({ :template => "books/show" })
  end
end
