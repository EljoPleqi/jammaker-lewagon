import { Component, OnInit } from '@angular/core';
import axios from 'axios';

@Component({
  selector: 'app-spotify-button',
  templateUrl: './spotify-button.component.html',
  styleUrls: ['./spotify-button.component.css'],
})
export class SpotifyButtonComponent implements OnInit {
  constructor() {}

  ngOnInit(): void {}
  queryString: String[] = [];
  url = 'https://accounts.spotify.com/authorize';

  queryParams = {
    client_id: '2b8194f35c8f4c4680a5d6fae1df3402',
    redirect_uri: 'http://localhost:4200/auth/spotify/callback',
    response_type: 'code',
    scope: [
      'user-read-email',
      'user-read-private',
      'playlist-modify-public',
      'playlist-modify-private',
      'user-modify-playback-state',
      'user-read-playback-state',
      'streaming',
      'user-library-read',
      'user-library-modify',
    ].join('+'),
  };

  getAuthCode() {
    for (const [key, value] of Object.entries(this.queryParams)) {
      this.queryString.push(`${key}=${value}`);
    }
    window.location.replace(`${this.url}?${this.queryString.join('&')}`);
  }
}
