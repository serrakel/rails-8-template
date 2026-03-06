class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string  :title
      t.string  :author
      t.text    :description
      t.string  :cover_image_url
      t.integer :published_year
      t.string  :isbn

      t.timestamps
    end
  end
end
