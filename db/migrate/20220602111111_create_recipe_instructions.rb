class CreateRecipeInstructions < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_instructions do |t|

      t.timestamps
    end
  end
end
