class RecipesController < ApplicationController
  require "open-uri"
  before_action :find_user, only: %i[create_playlist fetch]

  def index
    @recipes = Recipe.all
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipes_params)
    @recipe = Recipe.scraper(@recipe)
    @recipe.user = current_user
    @recipe.save
    @instructions = Instruction.parse(@recipe.steps)
    @instructions.each do |instruction|
      Instruction.create(content: instruction, recipe: @recipe)
    end
    create_playlist(@recipe.preptime.to_i, @recipe.title)
    redirect_to recipe_path(@recipe)
  end

  def show
    #find recipes to show
    #show all of the instructions for that recipes
    @recipe = Recipe.find(params[:id])
    @instructions = @recipe.instructions
  end

  def destroy
    @recipes.destroy
    redirect_to recipes_path
  end

  private

  # * the #create_playlist takes two paraments the spotify user and the prep_time from the scrapper
  # * the #create_playlist generates and populates the user recipe
  def create_playlist(prep_time, playlist_name)
    user_hash = JSON.parse(current_user.spotify_hash)
    spotify_user = RSpotify::User.new(user_hash)
    # * CREATE THE PLAYLIST
    playlist = spotify_user.create_playlist!("Jammaker-#{playlist_name}")
    # * currate the songs array, it must hold either tracks or a collection of strings that is a valid spotify track uri
    songs = []
    # TODO: calculate the total duration of all the songs inside the songs array
    playlist_time = 0
    # * looping until the total playlist time reaches the total preptime
    until playlist_time == prep_time
      # TODO: loop logic
      song = fetch("punk")
      playlist_time += song[0][1] / 60_000 unless song.nil?
      songs.push(song[0][0])
    end

    playlist.add_tracks!(songs)

    @message = ["Playlist all done 🎉 total playlist time => #{playlist_time}"] # * <--- RETURN
  end

  def fetch(cat)
    user_hash = JSON.parse(current_user.spotify_hash)
    spotify_user = RSpotify::User.new(user_hash)


    # * Pull 20 playlists of a certain category in spotify
    category = RSpotify::Category.find(cat)
    # tracks = uri.open()
    playlists = category.playlists
    # * pull 1 random playlist out of the collection of 20
    playlist_response = playlists[rand(playlists.size) - 1].href
    x = JSON.parse( URI.open(playlist_response, {'Authorization'=>"Bearer #{spotify_user.credentials['token']}", "Content-Type"=>"application/json"}).read)
    y = x['tracks']['items'].map { |item| [item['track']['uri'], item['track']['duration_ms']] unless item.nil? }
    # tracks = playlist_response.tracks.sample(1) unless playlist_response.nil? # * <--- RETURN SINGLE TRACK IN RANDOM POSITION
    y.sample(1)
  end

  def recipes_params
    params.require(:recipe).permit(:url)
  end

  def find_user
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    user = User.find_by(email: spotify_user.email)
    user_hash = JSON.parse(user.spotify_hash)
    spotify_user = RSpotify::User.new(user_hash)
  end
end
