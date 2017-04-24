class RemoveUniqueConstraintOnBookInCheckouts < ActiveRecord::Migration[5.0]
  def change
    remove_index :checkouts, :book_id
    add_index :checkouts, :book_id
  end
end
