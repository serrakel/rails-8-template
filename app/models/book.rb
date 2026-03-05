# == Schema Information
#
# Table name: books
#
#  id              :bigint           not null, primary key
#  author          :string
#  cover_image_url :string
#  description     :text
#  isbn            :string
#  published_year  :integer
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Book < ApplicationRecord
  has_many :user_books
  has_many :users, through: :user_books
  validates :title, :author, presence: true
end
