class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.text :description
      t.date :published_date
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
