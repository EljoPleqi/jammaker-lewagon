import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-spotify-button',
  templateUrl: './spotify-button.component.html',
  styleUrls: ['./spotify-button.component.css'],
})
export class SpotifyButtonComponent implements OnInit {
  constructor() {}

  ngOnInit(): void {}

  login() {
    fetch('http://localhost:3000/auth/spotify/callback').then((data) =>
      console.log(data)
    );
  }
}
