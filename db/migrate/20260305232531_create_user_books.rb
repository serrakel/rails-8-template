class CreateUserBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :user_books do |t|
      t.integer :user_id
      t.integer :book_id
      t.integer :rating
      t.text :liked_aspects
      t.text :disliked_aspects
      t.date :date_read
      t.boolean :is_favorite
      t.string :reddit_discussion_url
      t.string :category

      t.timestamps
    end
  end
end
