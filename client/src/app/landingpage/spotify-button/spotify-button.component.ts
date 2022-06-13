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

  async login() {
    await axios
      .get('http://localhost:3000/login')
      .then((res) => console.log(res));
  }
}
