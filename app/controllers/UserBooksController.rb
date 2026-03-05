class UserBooksController < ApplicationController
  before_action(:require_user_signed_in) 
  
  def index
    user_id = current_user.id

    @user_books = UserBook.where({ :user_id => user_id })

    if params.fetch("q", "").present?
      query_text = params.fetch("q").downcase
      wildcard = "%" + query_text + "%"

      @user_books = @user_books
        .joins("INNER JOIN books ON books.id = user_books.book_id")
        .where(
          ["LOWER(books.title) LIKE ? OR LOWER(books.author) LIKE ?", wildcard, wildcard]
        )
    end

    if params.fetch("category", "").present?
      @user_books = @user_books.where({ :category => params.fetch("category") })
    end

    if params.fetch("favorites", "").present?
      @user_books = @user_books.where({ :is_favorite => true })
    end

    @user_books = @user_books.order({ :created_at => :desc })

    base_user_books = UserBook.where({ :user_id => user_id })

    @categories = base_user_books
      .where.not({ :category => [nil, ""] })
      .distinct
      .pluck(:category)
      .sort

    @total_books = base_user_books.count

    @avg_rating = base_user_books
      .where.not({ :rating => nil })
      .average(:rating)

    if @avg_rating != nil
      @avg_rating = @avg_rating.round(1)
    end

    render({ :template => "user_books/index" })
  end

  def show
    the_id = params.fetch("id")
    @user_book = UserBook.where({ :id => the_id, :user_id => current_user.id }).at(0)

    render({ :template => "user_books/show" })
  end

  def new
    @user_book = UserBook.new

    render({ :template => "user_books/new" })
  end

  def create
    @user_book = UserBook.new

    @user_book.user_id = current_user.id
    @user_book.book_id = params.fetch("query_book_id")
    @user_book.rating = params.fetch("query_rating")
    @user_book.liked_aspects = params.fetch("query_liked_aspects")
    @user_book.disliked_aspects = params.fetch("query_disliked_aspects")
    @user_book.date_read = params.fetch("query_date_read")
    @user_book.is_favorite = params.fetch("query_is_favorite")
    @user_book.reddit_discussion_url = params.fetch("query_reddit_discussion_url")
    @user_book.category = params.fetch("query_category")

    @user_book.save

    redirect_to("/user_books")
  end

  def edit
    the_id = params.fetch("id")
    @user_book = UserBook.where({ :id => the_id, :user_id => current_user.id }).at(0)

    render({ :template => "user_books/edit" })
  end

  def update
    the_id = params.fetch("id")
    @user_book = UserBook.where({ :id => the_id, :user_id => current_user.id }).at(0)

    @user_book.rating = params.fetch("query_rating")
    @user_book.liked_aspects = params.fetch("query_liked_aspects")
    @user_book.disliked_aspects = params.fetch("query_disliked_aspects")
    @user_book.date_read = params.fetch("query_date_read")
    @user_book.is_favorite = params.fetch("query_is_favorite")
    @user_book.reddit_discussion_url = params.fetch("query_reddit_discussion_url")
    @user_book.category = params.fetch("query_category")

    @user_book.save

    redirect_to("/user_books/" + @user_book.id.to_s)
  end

  def destroy
    the_id = params.fetch("id")
    the_user_book = UserBook.where({ :id => the_id, :user_id => current_user.id }).at(0)

    if the_user_book != nil
      the_user_book.destroy
    end

    redirect_to("/user_books")
  end
end
