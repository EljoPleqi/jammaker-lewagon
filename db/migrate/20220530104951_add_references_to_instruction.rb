class AddReferencesToInstruction < ActiveRecord::Migration[6.1]
  def change
    add_reference :recipe_instructions, :recipes, foreign_key: true
    add_reference :recipe_instructions, :instructions, foreign_key: true
  end
end
