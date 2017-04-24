class AddFineAndClosedAtToCheckouts < ActiveRecord::Migration[5.0]
  def change
    add_monetize :checkouts, :fine
    add_column :checkouts, :closed_at, :datetime
  end
end
