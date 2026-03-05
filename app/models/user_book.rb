# == Schema Information
#
# Table name: user_books
#
#  id                    :bigint           not null, primary key
#  category              :string
#  date_read             :date
#  disliked_aspects      :text
#  is_favorite           :boolean
#  liked_aspects         :text
#  rating                :integer
#  reddit_discussion_url :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  book_id               :integer
#  user_id               :integer
#
class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book
  accepts_nested_attributes_for :book

  validates :rating, numericality: { in: 1..5 }, allow_nil: true
  validates :user_id, uniqueness: { scope: :book_id }
end
