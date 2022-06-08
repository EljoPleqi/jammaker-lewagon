import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["output"];

  token =
    "BQCHhLEACkfv7bnW77nMekJrarJRP2ww0snFjk6DCd85DIbSExYm-vfx5nVxioab1ZOl7v--DYc9m9TI_PApjLTHG0YQsdLLeO0Ur8WqSSiS4m9ueYj5n4k9tLHI3sFDHGOrv9vabfSfDiRKQdU16uUvwDXhjKulLPgdsQcyy8G-wBsVvh4D2sGv2xg";

  connect() {
    const script = document.createElement("script");
    script.src = "https://sdk.scdn.co/spotify-player.js";
    script.async = true;

    document.body.appendChild(script);

    window.onSpotifyWebPlaybackSDKReady = () => {
      const player = new window.Spotify.Player({
        name: "Web Playback SDK",
        getOAuthToken: (cb) => {
          cb(this.token);
        },
        volume: 0.5,
      });
      console.log(player);
      player.connect();
    };
  }
}
