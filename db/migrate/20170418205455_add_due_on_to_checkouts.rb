class AddDueOnToCheckouts < ActiveRecord::Migration[5.0]
  def change
    add_column :checkouts, :due_on, :datetime, null: false 
  end
end
