class AddReferencesToInstructions < ActiveRecord::Migration[6.1]
  def change
    add_reference :instructions, :recipe, null: false, foreign_key: true
  end
end
