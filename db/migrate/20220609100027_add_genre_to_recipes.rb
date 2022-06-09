class AddGenreToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :genre, :string
  end
end
