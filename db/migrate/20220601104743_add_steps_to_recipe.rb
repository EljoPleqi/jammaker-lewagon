class AddStepsToRecipe < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :steps, :string
  end
end
