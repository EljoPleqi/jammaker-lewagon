class CreatePlaylists < ActiveRecord::Migration[6.1]
  def change
    create_table :playlists do |t|
      t.string :spotify_playlist_id
      t.references :recipe, foreign_key: true

      t.timestamps
    end
  end
end
