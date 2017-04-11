class CreateCheckouts < ActiveRecord::Migration[5.0]
  def change
    create_table :checkouts do |t|
      t.timestamps null: false
      t.references :book, index: { unique: true }, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false
    end
  end
end
