# == Schema Information
#
# Table name: user_books
#
#  id                    :bigint           not null, primary key
#  category              :string
#  date_read             :date
#  disliked_aspects      :text
#  is_favorite           :boolean          default(FALSE)
#  liked_aspects         :text
#  rating                :integer
#  reddit_discussion_url :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  book_id               :bigint
#  user_id               :bigint
#
# Indexes
#
#  index_user_books_on_book_id              (book_id)
#  index_user_books_on_user_id              (user_id)
#  index_user_books_on_user_id_and_book_id  (user_id,book_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (user_id => users.id)
#
class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book
  accepts_nested_attributes_for :book

  validates :rating, numericality: { in: 1..5 }, allow_nil: true
  validates :user_id, uniqueness: { scope: :book_id }
end
