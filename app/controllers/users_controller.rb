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
    redirect_to recipes_path # * redirect to the dashboard
  end



  def query
    # * get user input for the category
  end
end
