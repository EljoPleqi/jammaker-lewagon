# app/model/concern/spotify_omniauth_extension.rb

module SpotifyOmniauthExtension
  extend ActiveSupport::Concern

  def callback_url
    full_host + script_name + callback_path
  end
end
