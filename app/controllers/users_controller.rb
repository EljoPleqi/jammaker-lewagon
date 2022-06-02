class UsersController < ApplicationController
  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    # TODO: save a copy of the spotify_user into a hash
    # TODO: make a user Instance with the saved hash
    # * -----
    spotify_user_hash = spotify_user.to_json

    if User.find_by(email: spotify_user.email).nil?
      User.create!(username: spotify_user.display_name, email: spotify_user.email, password: "qwerty", spotify_hash: spotify_user_hash)
      sign_in User.find_by(email: spotify_user.email)
    else
      user = User.find_by(email: spotify_user.email)
      user_hash = JSON.parse(user.spotify_hash)
      spotify_user = RSpotify::User.new(user_hash)
      sign_in User.find_by(email: spotify_user.email)
    end
    # * -----
    # *  call the method that get's user input
    # cat = query # ! does not redirect open the for the input, maybe include the form in the same view?
    # cat = "punk"
    # * -----
    # * create a boolean_variable which changes state on a click event in the frontend
    # * use the boolean_variable to control if the #create_playlist will run or not
    # create_playlist(spotify_user, cat, 15) # * execute this line if boolean-var == 'true'
    redirect_to recipes_path
  end

  # * the #create_playlist takes two paraments the spotify user and the prep_time from the scrapper
  # * the #create_playlist generates and populates the user recipe
  def create_playlist(user, cat, prep_time)
    # * CREATE THE PLAYLIST
    playlist = user.create_playlist!('Jammaker-recipe-name')
    # * currate the songs array, it must hold either tracks or a collection of strings that is a valid spotify track uri
    songs = []
    # TODO: calculate the total duration of all the songs inside the songs array
    playlist_time = 0
    # * looping until the total playlist time reaches the total preptime
    until playlist_time == prep_time
      # TODO: loop logic
      song = fetch(cat)
      playlist_time += song.duration_ms / 60_000
      songs.push(song)
    end

    playlist.add_tracks!(songs)

    @message = ["Playlist all done 🎉 total playlist time => #{playlist_time}"] # * <--- RETURN
  end

  def fetch(cat)
    # * Pull 20 playlists of a certain category in spotify
    category = RSpotify::Category.find(cat)
    # * pull 1 random playlist out of the collection of 20
    res = category.playlists[rand(category.playlists.size) - 1]
    res.tracks[rand(20)] # * <--- RETURN SINGLE TRACK IN RANDOM POSITION
  end

  def query
    # * get user input for the category
  end
end
