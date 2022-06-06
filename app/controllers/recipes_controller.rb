class RecipesController < ApplicationController
  require 'rest-client'
  before_action :spotify_urls, only: [:fetch_songs]

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
    # find recipes to show
    # show all of the instructions for that recipes
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
    # * currate the songs array, it must hold either tracks or a collection of strings that is a valid spotify track uri
    songs = []
    # TODO: calculate the total duration of all the songs inside the songs array
    playlist_time = 0
    # * looping until the total playlist time reaches the total preptime
    until playlist_time == prep_time + 2 || playlist_time == prep_time - 2
      # TODO: loop logic
      song = fetch_songs
      playlist_time += song[1] / 60_000 unless song.nil?
      songs.push(song[0]) unless songs.include?(song[0])
    end
    # * CREATE THE PLAYLIST

    spotify_user = RSpotify::User.new(JSON.parse(current_user.spotify_hash))
    playlist = spotify_user.create_playlist!("Jammaker-#{playlist_name}")
    raise
    recipe_playlist = Playlist.create(spotify_playlist_id: playlist.id, recipe_id: @recipe.id, recipes_id: @recipe.id)
    raise
    playlist.add_tracks!(songs)
  end

  def fetch_songs
    user_hash = JSON.parse(current_user.spotify_hash)
    enc_credentials = "Bearer #{user_hash['credentials']['token']}"
  #   # * get the categories
  #   categories = RestClient::Request.new(
  #   {
  #     url: spotify_urls[:categories],
  #     method: "GET",
  #     headers: {"Accept" => "application/json", "Content-Type" => "application/json", "Authorization" => enc_credentials },
  #   }
  # ).execute do |response, _request, _result|
  #     case response.code
  #     when 400
  #       [:error, as_json(response)]
  #     when 200
  #       categories = JSON.parse(response.body.as_json)
  #     else
  #       fail "Invalid response #{response.as_json} received."
  #     end
  # end

    # TODO: retrieve the playlists from the category repsonse
    # * get the category url
    category_url =  "https://api.spotify.com/v1/browse/categories/pop"

    # * get the playlist url from the category
    playlist_data = JSON.parse(RestClient.get("#{category_url}/playlists",
                                              { "Accept" => "application/json",
                                                "Content-Type" => "application/json",
                                                "Authorization" => enc_credentials }))

    playlist_url =  playlist_data['playlists']['items'][rand(playlist_data.length) - 1]['href']

    song_data = JSON.parse(RestClient.get(playlist_url + "/tracks?&limit=1&offset=#{rand(20)}",
                                          { "Accept" => "application/json", "Content-Type" => "application/json",
                                            "Authorization" => enc_credentials }))
    [song_data['items'].first['track']['uri'], song_data['items'].first['track']['duration_ms']]
  end

  def recipes_params
    params.require(:recipe).permit(:url)
  end

  def store_user_cred
    { access_token: spotify_user.credentials['token'],
      refresh_token: spotify_user.credentials['refresh_token'],
      time_of_creation: Time.now }
  end

  def spotify_urls
    spotify_urls =  {
      categories: "https://api.spotify.com/v1/browse/categories/",
      token: "https://accounts.spotify.com/api/token",
      refresh: 'https://api.spotify.com/v1/refresh'
    }
  end
end
