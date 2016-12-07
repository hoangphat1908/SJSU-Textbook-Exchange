class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :edition
      t.string :picture
      t.string :author
      t.string :author
      t.string :isbn
      t.string :subject
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
