import { Injectable } from '@angular/core';
import { Recipe } from '../interfaces/recipe.interface';
import { HttpClient, HttpParams } from '@angular/common/http';
import { map } from 'rxjs/operators';
import { UserResponse } from '../interfaces/user-response.interface';

@Injectable({
  providedIn: 'root',
})
export class UserLoginService {
  constructor(private http: HttpClient) {}
  code: string | any = '';

  user: any;
  recipes: Recipe[] = [];

  getAccessToken() {
    this.code = new URLSearchParams(window.location.search).get('code');

    // return the data of the http get request
    return this.http
      .get<UserResponse>('http://localhost:3000/api/token', {
        params: new HttpParams().set('code', this.code),
      })
      .pipe(map((user) => (this.user = user)));
  }
}