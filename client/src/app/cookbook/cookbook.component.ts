import { Component, OnInit } from '@angular/core';
import { Recipe } from '../recipe/Recipe.modal';
import axios from 'axios';

@Component({
  selector: 'app-cookbook',
  templateUrl: './cookbook.component.html',
  styleUrls: ['./cookbook.component.css'],
})
export class CookbookComponent implements OnInit {
  user: any;
  recipes: Recipe[] = [];
  loaded: boolean = false;

  constructor() {}

  ngOnInit(): void {
    this.getAccessToken();
  }

  async getAccessToken() {
    const code = new URLSearchParams(window.location.search).get('code');
    await axios
      .get('http://localhost:3000/api/token', { params: { code: code } })
      .then((res) => {
        this.user = res.data.user;
        this.recipes = res.data.recipes;
        this.loaded = true;
      });
  }
}
