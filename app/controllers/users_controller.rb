class UsersController < ApplicationController
  require 'rest-client'

  # * Get the access token and the refresh token

  def token
    redirect_to '/' if params[:error]
    # * -----
    body = {
      grant_type: "authorization_code",
      code: params[:code],
      redirect_uri: 'http://localhost:4200/auth/spotify/callback',
      client_id: ENV['SPOTIFY_CLIENT_ID'],
      client_secret: ENV['SPOTIFY_CLIENT_SECRET']
    }
    auth_response = JSON.parse(RestClient.post('https://accounts.spotify.com/api/token', body))
    find_user(auth_response)
  end

  # * Find the user in the database

  def find_user(auth_response)
    header = { Authorization: "Bearer #{auth_response['access_token']}" }
    spotify_user = JSON.parse(RestClient.get('https://api.spotify.com/v1/me', header))
    if User.find_by(email: spotify_user['email']).nil? # * IF USER DOES NOT EXIST CREATE USER
      User.create!(username: spotify_user['display_name'], avatar: spotify_user['images'][0]['url'], email: spotify_user['email'], password: spotify_user['id'].to_s, spotify_hash: spotify_user)
      sign_in User.find_by(email: spotify_user['email']) # bug here
    else # * IF USER EXISTS GET NEW ACCESS TOKEN
      user = User.find_by(email: spotify_user['email'])
      user_hash = fetch_access(user)
      sign_in User.find_by(email: spotify_user['email']) # bug here
      user.update("spotify_hash" => user_hash.to_json)
    end
    # * -----
    response = {
      user: current_user,
      recipes: current_user.recipes
    }
    render json: response
  end

  def fetch_access(user)
    # * encoding app credentials
    enc_credentials = "Basic  #{Base64.strict_encode64("#{ENV['SPOTIFY_CLIENT_ID']}:#{ENV['SPOTIFY_CLIENT_SECRET']}")}"
    puts enc_credentials
    # * retrieve user from the database
    user_hash = JSON.parse(user.spotify_hash)
    # * get spotify urls
    refresh_token = user_hash['credentials']['refresh_token']
    # * the new access token
    RestClient::Request.new(
      {
        url: 'https://accounts.spotify.com/api/token',
        method: "POST",
        headers: { "Content-Type" => "application/x-www-form-urlencoded", "Authorization" => enc_credentials },
        payload: { "grant_type" => 'refresh_token', "refresh_token" => refresh_token }
      }
    ).execute do |response, _request, _result|
      case response.code
      when 400
        JSON.parse(response.body)
      when 200
        new_cred = JSON.parse(response.body.as_json)
        puts "#{new_cred} line 57"
        user_hash["credentials"]['token'] = new_cred['access_token']
      else
        fail "Invalid response #{response.as_json} received."
      end
    end
    user["spotify_hash"] = user_hash # * <-- RETURN THE NEW USER HASH
  end
end
