import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["output"];
  token =
    "BQDwTeOPUn_qv9htqdxkuV0fY4Xyig106USBafIPSQ3xbkn9TcFLEK-LaHJQKGpaHLhWsN6A2ahld9xhuw3vMuAbaqrsfSvc987DsAfqIdUn8BiTrh6RhHpAOUOxjjo8iRNFF0uQTHPyJCjGc64wwx5PIIs7CDyg7xLbsh61N4N2dT8AnJu75vbLaik";
  connect() {
    const script = document.createElement("script");
    script.src = "https://sdk.scdn.co/spotify-player.js";
    script.async = true;

    document.body.appendChild(script);

    window.onSpotifyWebPlaybackSDKReady = () => {
      const player = new window.Spotify.Player({
        name: "Jammaker",
        getOAuthToken: (cb) => {
          cb(this.token);
        },
        volume: 0.5,
      });
      player.addListener("ready", ({ device_id }) => {
        console.log("Ready with Device ID", device_id);
      });

      player.addListener("not_ready", ({ device_id }) => {
        console.log("Device ID has gone offline", device_id);
      });

      player.connect();
      console.log(this.ele);
    };
  }
}
