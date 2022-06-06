class AddPlaylistToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_reference :playlists, :recipe, null: false, foreign_key: true
  end
end
