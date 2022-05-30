class AddReferencesToPlaylist < ActiveRecord::Migration[6.1]
  def change
    add_reference :playlists, :recipies, foreign_key: true
  end
end
