class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :preptime
      t.string :instructions
      t.string :tags
      t.string :ingredients
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
