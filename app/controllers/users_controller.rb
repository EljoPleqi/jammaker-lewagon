class UsersController < ApplicationController
  require 'rest-client'

  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    # TODO: save a copy of the spotify_user into a hash
    # TODO: make a user Instance with the saved hash
    # * -----
    spotify_user_hash = spotify_user.to_json

    if User.find_by(email: spotify_user.email).nil? # * IF USER DOES NOT EXIST CREATE USER
      User.create!(username: spotify_user.display_name, email: spotify_user.email, password: spotify_user.uid.to_s, spotify_hash: spotify_user_hash)
      sign_in User.find_by(email: spotify_user.email)
    else # * IF USER EXISTS GET NEW ACCESS TOKEN
      user = User.find_by(email: spotify_user.email)
      user_hash = fetch_access(user)
      sign_in User.find_by(email: spotify_user.email)
      user.update("spotify_hash" => user_hash.to_json)
    end

    # * -----
    redirect_to recipes_path # * redirect to the dashboard
  end

  def spotify_urls
    {
      categories: "https://api.spotify.com/v1/browse/categories/",
      token: "https://accounts.spotify.com/api/token",
      refresh: 'https://api.spotify.com/v1/refresh'
    }
  end

  def fetch_access(user)
    # * encoding app credentials
    enc_credentials = "Basic  #{Base64.strict_encode64("#{ENV['SPOTIFY_CLIENT_ID']}:#{ENV['SPOTIFY_CLIENT_SECRET']}")}"
    # * retrieve user from the database
    user_hash = JSON.parse(user.spotify_hash)
    # * get spotify urls
    refresh_token = user_hash['credentials']['refresh_token']
    spotify_urls = spotify_urls()
    # * the new access token
    RestClient::Request.new(
      {
        url: spotify_urls[:token],
        method: "POST",
        headers: {  "Content-Type" => "application/x-www-form-urlencoded", "Authorization" => enc_credentials },
        payload: { "grant_type" => 'refresh_token', "refresh_token" => refresh_token }
      }
    ).execute do |response, _request, _result|
      case response.code
      when 400
        [:error, as_json(response)]
      when 200
        new_cred = JSON.parse(response.body.as_json)
        user_hash["credentials"]['token'] = new_cred[:access_token]
      else
        fail "Invalid response #{response.as_json} received."
      end
    end
    user["spotify_hash"] = user_hash # * <-- RETURN THE NEW USER HASH
  end
end
