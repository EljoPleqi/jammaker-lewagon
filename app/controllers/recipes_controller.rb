class RecipesController < ApplicationController
  # require 'rest-client'
  before_action :spotify_urls, only: [:fetch_songs]
  before_action :return_header, only: [:fetch_songs, :fetch_category_url]

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
    @instructions.shift
    @instructions.each do |instruction|
      Instruction.create(content: instruction, recipe: @recipe)
    end
    create_playlist(@recipe.preptime.to_i, @recipe.title)
    redirect_to recipe_path(@recipe)
  end

  def show
    # find recipes to show
    # show all of the instructions for that recipes
    @recipe = Recipe.find(params[:id])
    @instructions = @recipe.instructions
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(favorite: true)
    redirect_to recipe_path(@recipe)
  end

  def destroy
    @recipes.destroy
    redirect_to recipes_path
  end

  private

  # * the #create_playlist takes two paraments the spotify user and the prep_time from the scrapper
  # * the #create_playlist generates and populates the user recipe
  def create_playlist(prep_time, playlist_name)
    # * currate the songs array, it must hold either tracks or a collection of strings that is a valid spotify track uri
    songs = []
    # TODO: calculate the total duration of all the songs inside the songs array
    playlist_time = 0
    # * looping until the total playlist time reaches the total preptime
    until playlist_time.to_f >= prep_time.to_f
      # TODO: loop logic
      song = fetch_songs
      playlist_time += song[1] / 60_000 unless song.nil?
      puts "playlist time#{playlist_time} prep time #{prep_time}"
      songs.push(song[0]) unless songs.include?(song[0])
    end
    # * CREATE THE PLAYLIST

    spotify_user = RSpotify::User.new(JSON.parse(current_user.spotify_hash))
    playlist = spotify_user.create_playlist!("Jammaker-#{playlist_name}")
    recipe_playlist = Playlist.new(spotify_playlist_id: playlist.id)
    recipe_playlist['recipe_id'] = @recipe.id
    recipe_playlist.save
    playlist.add_tracks!(songs)
  end

  def fetch_category_url
    # * get the categories
    categories = ["pop", 'punk', 'rock', 'hiphop', 'chill', "indie_alt"]
    "https://api.spotify.com/v1/browse/categories/#{categories[rand(categories.length) - 1]}"
  end

  def fetch_songs
    hdrs = return_header
    # * get the playlist url from the category
    playlist_response = fetch_category_url
    if RestClient::Request.new({ url: "#{playlist_response}/playlists",
                                 method: "GET",
                                 headers: hdrs }).execute.code == 404
      playlist_response = fetch_category_url
    end

    RestClient::Request.new({ url: "#{playlist_response}/playlists",
                              method: "GET",
                              headers: hdrs }).execute do |response, _request, _result|
                                                    case response.code
                                                    when 400
                                                      JSON.parse(response.body)
                                                    when 200
                                                      playlist_response = JSON.parse(response.body)
                                                    else
                                                      fail "Invalid response #{response.as_json} received."
                                                    end
                                                  end

    playlist_url =  playlist_response['playlists']['items'][rand(playlist_response.length) - 1]['href']

    # * get the song url from the playlist
    song_response = RestClient::Request.new({ url: playlist_url + "/tracks?&limit=1&offset=#{rand(5)}",
                                              method: "GET",
                                              headers: hdrs }).execute do |response, _request, _result|
                                                case response.code
                                                when 400
                                                  puts JSON.parse(response.body)
                                                when 200
                                                  puts "line 127"
                                                  song_response = JSON.parse(response.body)
                                                else
                                                  fail "Invalid response #{response.as_json} received."
                                                end
                                              end

    [song_response['items'].first['track']['uri'], song_response['items'].first['track']['duration_ms']] # * <---- return song
  end

  def recipes_params
    params.require(:recipe).permit(:url)
  end

  def spotify_urls
    spotify_urls = {
      categories: "https://api.spotify.com/v1/browse/categories?limit=10&offset=5",
      token: "https://accounts.spotify.com/api/token",
      refresh: 'https://api.spotify.com/v1/refresh'
    }
  end

  def return_header
    user_hash = JSON.parse(current_user.spotify_hash)
    enc_credentials = "Bearer #{user_hash['credentials']['token']}"
    hdrs = { "Accept" => "application/json",
                "Content-Type" => "application/json",
                "Authorization" => enc_credentials }
  end
end
