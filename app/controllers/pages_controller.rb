require 'rspotify'
require 'json'

class PagesController < ApplicationController
  RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'])

  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def scraper
    filepath = "/Users/phoenix/code/FabioDG7/jammaker/app/controllers/chicken.html"
    # 1. We get the HTML page content
    html_content = File.open(filepath)
    # 2. We build a Nokogiri document from this file
    doc = Nokogiri::HTML(html_content)
    @elements = doc.search('.recipe-meta-item-body')
    @preptime = @elements[2].text.strip
    @elements2 = doc.search('.headline')
    @title = @elements2.text.strip
    @elements3 = doc.search('.ingredients-section')
    @ingredients = @elements3.text.strip
    @elements4 = doc.search('.recipe-instructions')
    @instructions = @elements4.text.strip
    @recipe = {
      title: @title,
      preptime: @preptime,
      ingredients: @ingredients,
      instructions: @instructions
    }
    #@preptime
  end

  def populate_playlist
    @playlist = []
    prep_time = 15
    playlist_time = 0

  until playlist_time == prep_time do
      @playlist << fetch
      playlist_time += 1
  end
  @playlist

  end

  def fetch

    RSpotify.raw_response = true
    response = RSpotify::Recommendations.generate(seed_genres: ['blues', 'country'])
    results_serialized = JSON.parse(response)
    results = results_serialized.to_hash
    result = results["tracks"][rand(20)]
    @result = result["album"]["href"]

  end

  def query
    @query = params[:query]

  end

end
